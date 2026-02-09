local nnmap = require('config/options/utils').nnmap

require("undo-glow").setup({
    animation = {
        enabled = true,
        duration = 300,
        animation_type = "pulse",
        window_scoped = true,
    },
    highlights = {
        search = {
            hl_color = { bg = "#793D54" }, -- Dark muted pink
        },
        cursor = {
            hl_color = { bg = "#76946a" }, -- Dark muted green
        },
    },
    priority = 2048 * 3,
})
nnmap('n',
    function()
        require("undo-glow").search_next({
            animation = {
                animation_type = "pulse",
            },
        })
        local opts = {
            animation = {
                animation_type = "pulse",
            },
        }
        opts = require("undo-glow.utils").merge_command_opts("UgSearch", opts)
        local pos = require("undo-glow.utils").get_current_cursor_row()
        require("undo-glow").highlight_region(vim.tbl_extend("force", opts, {
            s_row = pos.s_row,
            s_col = pos.s_col,
            e_row = pos.e_row,
            e_col = pos.e_col,
            force_edge = opts.force_edge == nil and true or opts.force_edge,
        }))
    end,
    { desc = "Undo-glow search next with highlight"}
)
nnmap('N',
    function()
        require("undo-glow").search_prev({
            animation = {
                animation_type = "strobe",
            },
        })
    end,
    {desc = "Undo-glow search prev with highlight"}
)
vim.api.nvim_create_autocmd("CursorMoved", {
    desc = "Highlight when cursor moved significantly",
    callback = function()
        require("undo-glow").cursor_moved(
            {
                animation = {
                    animation_type = "pulse",
                }
            },
            {
                steps_to_trigger = 10, -- Jump threshold
                ignored_ft = { "mason", "lazy" }, -- Skip these filetypes
            }
        )
    end,
})
vim.api.nvim_create_autocmd("FocusGained", {
    desc = "Highlight when focus gained",
    callback = function()
        local opts = {
            animation = {
                animation_type = "pulse",
            },
        }

        opts = require("undo-glow.utils").merge_command_opts("UgCursor", opts)
        local pos = require("undo-glow.utils").get_current_cursor_row()

        require("undo-glow").highlight_region(vim.tbl_extend("force", opts, {
            s_row = pos.s_row,
            s_col = pos.s_col,
            e_row = pos.e_row,
            e_col = pos.e_col,
            force_edge = opts.force_edge == nil and true or opts.force_edge,
        }))
    end,
})
vim.api.nvim_create_autocmd("CmdlineLeave", {
    desc = "Highlight when search cmdline leave",
    callback = function()
        require("undo-glow").search_cmd({
            animation = {
                animation_type = "pulse",
            },
        })
    end,
})
