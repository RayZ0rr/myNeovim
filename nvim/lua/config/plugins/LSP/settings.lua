--##########################################################################################################
-- LSP customization---------------------------------------------------------------------------
--###################################################################################################################
vim.lsp.set_log_level 'warn'

vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = {
    {"🭽", "FloatBorder"},
    {"▔", "FloatBorder"},
    {"🭾", "FloatBorder"},
    {"▕", "FloatBorder"},
    {"🭿", "FloatBorder"},
    {"▁", "FloatBorder"},
    {"🭼", "FloatBorder"},
    {"▏", "FloatBorder"},
}

local lsp_util = require 'vim.lsp.util'

local open_floating_preview_orig = lsp_util.open_floating_preview
function lsp_util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    return open_floating_preview_orig(contents, syntax, opts, ...)
end

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = true,
    signs = true,
    underline = false,
    update_in_insert = false,
    severity_sort = false,
    signs = {
        -- nvim 0.10.0 uses `nvim_buf_set_extmark`
        text = {
            [vim.diagnostic.severity.ERROR] = "", -- index:0
            [vim.diagnostic.severity.WARN]  = "", -- index:1
            [vim.diagnostic.severity.INFO]  = "", -- index:2
            [vim.diagnostic.severity.HINT]  = "󰌵", -- index:3
            [vim.diagnostic.severity.ERROR] = "", -- index:0
            [vim.diagnostic.severity.WARN]  = "", -- index:1
            [vim.diagnostic.severity.INFO]  = "", -- index:2
            [vim.diagnostic.severity.HINT]  = "", -- index:3
        },
    },
    float = {
        show_header = false,
        source = "if_many",
        border = "rounded",
    },
    -- float = { source = "always", },
})

-- Change diagnostic symbols in the sign column (gutter)
-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
-- for type, icon in pairs(signs) do
--     local hl = "DiagnosticSign" .. type
--     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- end

-- local orig_signs_handler = vim.diagnostic.handlers.signs
-- -- Override the built-in signs handler to aggregate signs
-- vim.diagnostic.handlers.signs = {
--     show = function(ns, bufnr, _, opts)
--         local diagnostics = vim.diagnostic.get(bufnr)

--         -- Find the "worst" diagnostic per line
--         local max_severity_per_line = {}
--         for _, d in pairs(diagnostics) do
--             local m = max_severity_per_line[d.lnum]
--             if not m or d.severity < m.severity then
--                 max_severity_per_line[d.lnum] = d
--             end
--         end

--         -- Pass the filtered diagnostics (with our custom namespace) to
--         -- the original handler
--         local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
--         orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
--     end,

--     hide = orig_signs_handler.hide
-- }

local formatting_callback = function(client, bufnr)
    vim.keymap.set('n', '<leader>lF', function()
        local params = util.make_formatting_params({})
        client.request('textDocument/formatting', params, nil, bufnr)
    end, {buffer = bufnr, desc='lsp formatting'})
end

--##########################################################################################################
-- LSP Keybindings and completion---------------------------------------------------------------------------
--###################################################################################################################

-- Global.
-----------------------------------------------------------------------------
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { remap=false, silent=true }
vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist , opts)
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })

local M = {}

-- buffer.
-----------------------------------------------------------------------------
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.lsp_on_attach = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    if client.server_capabilities.code_lens then
        vim.api.nvim_create_autocmd({'BufEnter', 'CursorHold', 'InsertLeave'}, {
            buffer = bufnr,
            callback = vim.lsp.codelens.refresh
        })
        vim.lsp.codelens.refresh()
    end

    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = 'rounded',
                source = 'always',
                prefix = ' ',
                scope = 'cursor',
            }
            vim.diagnostic.open_float(nil, opts)
        end
    })

    if client.server_capabilities.documentHighlightProvider then
        vim.cmd([[
            hi! link LspReferenceRead CursorLine
            hi! link LspReferenceText CursorLine
            hi! link LspReferenceWrite CursorLine
            " hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
        ]])
        vim.api.nvim_create_augroup('lsp_document_highlight', {
            clear = false
        })
        vim.api.nvim_clear_autocmds({
            group = 'lsp_document_highlight',
            buffer = bufnr,
        })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end

    if vim.g.logging_level == 'debug' then
        local msg = string.format("Language server %s started!", client.name)
        vim.notify(msg, 'info', {title = 'Nvim-config'})
    end

    -- Mappings.
    ------------------------------------------------------------------------
    -- See `:help vim.lsp.*` for documentation on any of the below functions

    -- local bufopts = { remap=false, silent=true, buffer=bufnr }
    local function buffer_map(key, result, desc)
        vim.keymap.set('n', key, result, {buffer=bufnr, desc=desc})
    end
    local toggle_diag = function()
        if not vim.b._diag_is_hidden then
            print("Diagnostic virtual text is now hidden.")
            vim.diagnostic.hide()
            -- vim.diagnostic.disable()
        else
            print("Diagnostic virtual text is now visible.")
            vim.diagnostic.show()
            -- vim.diagnostic.enable()
        end
        vim.b._diag_is_hidden = not vim.b._diag_is_hidden
    end

    buffer_map( '<leader>lD', vim.lsp.buf.declaration, 'vim.lsp.buf.declaration')
    buffer_map( '<leader>ld', vim.lsp.buf.definition, 'vim.lsp.buf.definition')
    buffer_map( '<leader>lh', vim.lsp.buf.hover, 'vim.lsp.buf.hover')
    buffer_map( '<leader>li', vim.lsp.buf.implementation, 'vim.lsp.buf.implementation')
    buffer_map( '<leader>lH', vim.lsp.buf.signature_help, 'vim.lsp.buf.signature_help')
    buffer_map( '<leader>lwa', vim.lsp.buf.add_workspace_folder, 'vim.lsp.buf.add_workspace_folder')
    buffer_map( '<leader>lwr', vim.lsp.buf.remove_workspace_folder, 'vim.lsp.buf.remove_workspace_folder')
    buffer_map( '<leader>lwl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, 'vim.lsp.buf.list_workspace_folders')
    buffer_map( '<leader>lt', vim.lsp.buf.type_definition, 'vim.lsp.buf.type_definition')
    buffer_map( '<leader>lR', vim.lsp.buf.rename, 'vim.lsp.buf.rename')
    vim.keymap.set({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, {buffer=bufnr, desc='vim.lsp.buf.code_action'})
    buffer_map( '<leader>lcl', vim.lsp.codelens.run, 'vim.lsp.codelens.run')
    buffer_map( '<leader>lr', vim.lsp.buf.references, 'vim.lsp.buf.references')
    buffer_map( '<leader>lf', function() vim.lsp.buf.format { async = true } end, 'vim.lsp.buf.formatting')
    buffer_map( '<leader>lL', function() toggle_diag() end, 'LSP Diagnostics toggle')

    -- Set some key bindings conditional on server capabilities
    formatting_callback(client, bufnr)
    -- if client.server_capabilities.document_formatting then
    --   buffer_map( '<leader>lf', vim.lsp.buf.formatting_sync, 'vim.lsp.buf.formatting_sync')
    -- end
    -- if client.server_capabilities.document_range_formatting then
    --   vim.keymap.set('x', '<leader>lf', vim.lsp.buf.range_formatting, {silent = true, buffer=bufnr, desc= 'vim.lsp.buf.range_formatting'})
    -- end

end

return M
