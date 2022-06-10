local nvim_lsp = require('lspconfig')

local custom_on_attach = require('plugins/LSP/settings').custom_on_attach

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- Add additional capabilities supported by nvim-cmp
local has_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if has_cmp then
  capabilities = cmp_lsp.update_capabilities(capabilities)
end
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

--##########################################################################################################
-- General lang server setup -----------------------------------------
--###################################################################################################################

local server_config = {
  capabilities = capabilities;
  on_attach = custom_on_attach;
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
  on_attach = custom_on_attach;
  flags = {
    debounce_text_changes = 150,
  },
  cmd = {
    "clangd",
    "--background-index",
  },
  -- root_dir = require('lspconfig/util').root_pattern("compile_commands.json", "compile_flags.txt", ".ccls"),
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


