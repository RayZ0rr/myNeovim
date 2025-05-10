local nvim_lsp = require('lspconfig')
local executable = require("config/options/utils").executable

local lsp_on_attach = require('config/plugins/LSP/settings').lsp_on_attach

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = lsp_on_attach
})

-- Add additional capabilities supported by nvim-cmp or blink
local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local has_blink, blink = pcall(require, "blink.cmp")
local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    has_cmp and cmp_nvim_lsp.default_capabilities() or {},
    has_blink and blink.get_lsp_capabilities() or {}
)

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
        vim.lsp.config(server, server_config)
        vim.lsp.enable(server)
    end
end

-- set up LSP for python
if executable('pyright-langserver') then
    vim.lsp.config('pyright', {
        capabilities = capabilities,
    })
    vim.lsp.enable('pyright')
else
    vim.notify("pyright-langserver not found!", 'warn', {title = 'LSP-config'})
end

-- set up bash-language-server
if executable('bash-language-server') then
    vim.lsp.config('bashls', {
        capabilities = capabilities,
        filetypes = { "sh", "bash", "zsh" },
    })
    vim.lsp.enable('bashls')
end

--##########################################################################################################
-- C/C++ config------------------------------------------
--###################################################################################################################
if executable('clangd') then
    vim.lsp.config('clangd', {
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
    vim.lsp.enable('clangd')
else
    vim.notify("clangd not found!", 'warn', {title = 'LSP-config'})
end

--##########################################################################################################
-- Golang config------------------------------------------
--###################################################################################################################
if executable('gopls') then
    vim.lsp.config('gopls', {
        capabilities = capabilities,
        -- capabilities = vim.tbl_deep_extend(
        --     "force", {}, capabilities, server.capabilities or {}
        -- ),
        diagnostics = {
            virtual_text = false -- don't use neovim's default virtual_text.
            -- Maybe try "rachartier/tiny-inline-diagnostic.nvim"
        },
        on_attach = function(client, bufnr)
            -- workaround for gopls not supporting semanticTokensProvider
            -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
            if not client.server_capabilities.semanticTokensProvider then
                local semantic = client.config.capabilities.textDocument.semanticTokens
                client.server_capabilities.semanticTokensProvider = {
                    full = true,
                    legend = {
                        tokenTypes = semantic.tokenTypes,
                        tokenModifiers = semantic.tokenModifiers,
                    },
                    range = true,
                }
            end
        end,

        settings = {
            -- https://go.googlesource.com/vscode-go/+/HEAD/docs/settings.md#settings-for
            -- https://www.lazyvim.org/extras/lang/go (borrowed some ideas from here)
            gopls = {
                analyses = {
                    fieldalignment = false, -- find structs that would use less memory if their fields were sorted
                    nilness = true,
                    unusedparams = true,
                    unusedwrite = true,
                    useany = true
                },
                codelenses = {
                    gc_details = false,
                    generate = true,
                    regenerate_cgo = true,
                    run_govulncheck = true,
                    test = true,
                    tidy = true,
                    upgrade_dependency = true,
                    vendor = true,
                },
                experimentalPostfixCompletions = true,
                hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true
                },
                gofumpt = true,
                semanticTokens = true,
                -- DISABLED: staticcheck
                --
                -- gopls doesn't invoke the staticcheck binary.
                -- Instead it imports the analyzers directly.
                -- This means it can report on issues the binary can't.
                -- But it's not a good thing (like it initially sounds).
                -- You can't then use line directives to ignore issues.
                --
                -- Instead of using staticcheck via gopls.
                -- We have golangci-lint execute it instead.
                --
                -- For more details:
                -- https://github.com/golang/go/issues/36373#issuecomment-570643870
                -- https://github.com/golangci/golangci-lint/issues/741#issuecomment-1488116634
                --
                -- staticcheck = true,
                usePlaceholders = true,
            }
        },
        -- it may overlap with `lvimuser/lsp-inlayhints.nvim`
        init_options = {
            usePlaceholders = true,
        },
    })
    vim.lsp.enable('gopls')
end
