local map = require('config/options/utils').map
local nnmap = require('config/options/utils').nnmap
local xnmap = require('config/options/utils').xnmap

require("yanky").setup({
    ring = {
        history_length = 100,
        storage = "sqlite",
        storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db", -- Only for sqlite storage
        sync_with_numbered_registers = true,
        cancel_event = "move",
        ignore_registers = { "_" },
        update_register_on_cycle = false,
        permanent_wrapper = nil,
    },
    picker = {
        select = {
            action = nil, -- nil to use default put action
        },
        telescope = {
            use_default_mappings = true, -- if default mappings should be used
            mappings = nil, -- nil to use default mappings or no mappings (see `use_default_mappings`)
        },
    },
    system_clipboard = {
        sync_with_ring = true,
        clipboard_register = nil,
    },
    highlight = {
        on_put = true,
        on_yank = true,
        timer = 150,
    },
    preserve_cursor_position = {
        enabled = true,
    },
    textobj = {
        enabled = false,
    },
})

nnmap("<leader>fr", "<cmd>YankyRingHistory<cr>")
map({"n","x"}, "p", "<Plug>(YankyPutAfter)")
map({"n","x"}, "P", "<Plug>(YankyPutBefore)")
map({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
map({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")
nnmap("<a-p>", "<Plug>(YankyPreviousEntry)")
nnmap("<a-n>", "<Plug>(YankyNextEntry)")
nnmap("=p", "<Plug>(YankyPutAfterFilter)")
nnmap("=P", "<Plug>(YankyPutBeforeFilter)")
nnmap("]p", "<Plug>(YankyPutIndentAfterLinewise)")
nnmap("[p", "<Plug>(YankyPutIndentBeforeLinewise)")
nnmap("]P", "<Plug>(YankyPutAfterLinewise)")
nnmap("[P", "<Plug>(YankyPutBeforeLinewise)")
xnmap('p', 'pgvy')


vim.api.nvim_set_hl(0, "YankyPut",{link="YankHighlightGroup"})
vim.api.nvim_set_hl(0, "YankyYanked",{link="YankHighlightGroup"})
