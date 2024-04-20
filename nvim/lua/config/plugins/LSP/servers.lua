local nvim_lsp = require('lspconfig')
local executable = require("config/options/utils").executable

local lsp_on_attach = require('config/plugins/LSP/settings').lsp_on_attach

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = lsp_on_attach
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- Add additional capabilities supported by nvim-cmp
local has_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if has_cmp then
  capabilities = cmp_lsp.default_capabilities()
end
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

--##########################################################################################################
-- General lang server setup -----------------------------------------
--###################################################################################################################

local server_config = {
  capabilities = capabilities;
  flags = {
    debounce_text_changes = 150,
  },
}

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers_executables = { cmake = 'cmake', vimls = ''}
for server, exec in pairs(servers_executables) do
    if executable(exec) then
        nvim_lsp[server].setup(server_config)
    end
end

-- set up LSP for python
if executable('pylsp') then
  nvim_lsp.pylsp.setup({
    capabilities = capabilities,
    settings = {
      pylsp = {
        plugins = {
          pylint = { enabled = true, executable = "pylint" },
          pyflakes = { enabled = false },
          pycodestyle = { enabled = false },
          jedi_completion = { fuzzy = true },
          pyls_isort = { enabled = true },
          pylsp_mypy = { enabled = true },
        },
      },
    },
    flags = {
      debounce_text_changes = 200,
    },
  })
else
  vim.notify("pylsp not found!", 'warn', {title = 'LSP-config'})
end

-- set up bash-language-server
if executable('bash-language-server') then
  nvim_lsp.bashls.setup({
    capabilities = capabilities,
    filetypes = { "sh", "bash", "zsh" },
  })
end

--##########################################################################################################
-- C/C++ config------------------------------------------
--###################################################################################################################

if executable('clangd') then
  nvim_lsp.clangd.setup({
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
    cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes"
    },
  })
else
  vim.notify("clangd not found!", 'warn', {title = 'LSP-config'})
end
