require('kanagawa').setup({
    colors = {
        theme = {
            dragon = {
                ui = {bg_gutter = "none"},
            },
        }
    },
    overrides = function(colors)
        return {
            CurSearch = {bg = '#793D54'},
            Statusline = {bg = colors.theme.ui.bg},
            StatuslineNC = {bg = colors.theme.ui.bg},
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },
            Pmenu = { fg = colors.theme.ui.shade0, bg = colors.theme.ui.bg_p1 },  -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = "NONE", bg = colors.theme.ui.bg_p2 },
            PmenuSbar = { bg = colors.theme.ui.bg_m1 },
            PmenuThumb = { bg = colors.theme.ui.bg_p2 },
        }
    end,
})
require("kanagawa").load("dragon")
