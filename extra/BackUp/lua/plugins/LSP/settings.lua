--##########################################################################################################
-- LSP Keybindings and completion---------------------------------------------------------------------------
--###################################################################################################################

local nvim_lsp = require('lspconfig')
vim.lsp.set_log_level 'debug'

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>le', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>lq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>lD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>lrn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- require 'illuminate'.on_attach(client)
  require'aerial'.on_attach(client, bufnr)
  if client.resolved_capabilities.document_highlight then
      vim.cmd [[
        hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
        hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]]
  end
end

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

-- Change diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

function PrintDiagnostics(opts, bufnr, line_nr, client_id)
  bufnr = bufnr or 0
  line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
  opts = opts or {['lnum'] = line_nr}

  local line_diagnostics = vim.diagnostic.get(bufnr, opts)
  if vim.tbl_isempty(line_diagnostics) then return end

  local diagnostic_message = ""
  for i, diagnostic in ipairs(line_diagnostics) do
    diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
    print(diagnostic_message)
    if i ~= #line_diagnostics then
      diagnostic_message = diagnostic_message .. "\n"
    end
  end
  vim.api.nvim_echo({{diagnostic_message, "Normal"}}, false, {})
end

vim.cmd [[ autocmd! CursorHold * lua PrintDiagnostics() ]]

vim.o.updatetime = 250
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
vim.cmd([[
augroup lspFloatingDiagnostics
  autocmd!
  autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float()
  " autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})
augroup end
]])

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

--##########################################################################################################
-- General lang server setup -----------------------------------------
--###################################################################################################################

local server_config = {
  capabilities = capabilities;
  on_attach = on_attach;
  flags = {
    debounce_text_changes = 150,
  },
}

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = { 'cmake','vimls'}
-- for _, lsp in ipairs(servers) do
-- 	nvim_lsp[lsp].setup {
-- 		--root_dir = vim.loop.cwd;
-- 		capabilities = capabilities;
-- 		on_attach = on_attach;
-- 		flags = {
-- 			debounce_text_changes = 150,
-- 		}
-- 	}
-- end

-- nvim_lsp.bashls.setup {
--     --root_dir = vim.loop.cwd;
--     filetypes = { "sh", "bash", "zsh" },
--     capabilities = capabilities,
--     on_attach = on_attach,
--     flags = {
-- 			debounce_text_changes = 150,
--     }
-- }

--##########################################################################################################
-- C++ config------------------------------------------
--###################################################################################################################

nvim_lsp.clangd.setup {
  capabilities = capabilities;
  on_attach = on_attach;
  flags = {
    debounce_text_changes = 150,
  },
  cmd = {
    "clangd",
    "--background-index",
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  -- on_init = function to handle changing offsetEncoding
  -- root_dir = require('lspconfig/util').root_pattern("compile_commands.json", "compile_flags.txt", ".ccls"),
  -- root_dir = root_pattern("compile_commands.json", "compile_flags.txt", ".git") or dirname
}

-- require('LSP/ccpp')
-- local cclscachepath = vim.fn.getenv("HOME").."/tmp/ccls-cache"
-- nvim_lsp.ccls.setup {
--     init_options = {
-- 	  --compilationDatabaseDirectory = "/home/ACM-Lab/Softwares/Installed/ccls/Debug" ;
-- 				index = {
-- 					threads = 0;
-- 				},
-- 				clang = {
-- 					excludeArgs = { "-frounding-math"} ;
-- 					resourceDir = "/usr/lib/llvm-7/lib/clang/7.0.1/include" ;
-- 				},
-- 				cache = {
-- 					directory = cclscachepath
-- 				},
--     },
--     cmd = {
-- 			'ccls',
-- 			'--log-file=/tmp/ccls.log',
-- 			'-v=1'
--     },
--     -- root_dir = require('lspconfig/util').root_pattern("compile_commands.json", "compile_flags.txt", ".ccls"),
--     capabilities = capabilities,
--     on_attach = on_attach,
--     flags = {
--       debounce_text_changes = 150,
--     }
--   --filetypes = { "c", "cpp", "objc", "objcpp" } ;
-- 	--capabilities = capabilities ;
-- 	--root_dir = vim.loop.cwd ;
-- 	--root_dir = root_pattern("compile_commands.json", "compile_flags.txt", ".git", ".ccls") or '/home/ACM-Lab/.Test' ;
-- 	--root_dir = {'echo', 'getcwd()'} ;
--   -- "--log-file=/tmp/ccls.log -v=1"
-- }

--##########################################################################################################
-- Null-ls config------------------------------------------
--###################################################################################################################

-- local null_ls = require("null-ls")
-- local null_sources = {
-- 		null_ls.builtins.formatting.stylua.with({
-- 			filetypes = { "lua"},
-- 		}),
--     -- null_ls.builtins.formatting.prettier,
--     -- null_ls.builtins.diagnostics.write_good,
--     -- null_ls.builtins.code_actions.gitsigns,
-- }
-- null_ls.setup({
--     -- you must define at least one source for the plugin to work
--     sources = null_sources,
-- })

