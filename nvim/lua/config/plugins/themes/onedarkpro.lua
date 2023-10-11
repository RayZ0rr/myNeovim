local onedarkpro = require("onedarkpro")
onedarkpro.setup({
    -- Override default colors. Can specify colors for "onelight" or "onedark" themes by passing in a table
    colors = {
        onedark = {
            bg = "#1e1e1e", -- dark
            bg = "#151515",
            red = "#B66467",
            yellow = "#D9BC8C",
            -- purple = "#A988B0",
        },
    },
    highlights = {  -- Override default highlight groups
        -- Cursorline = { bg="Grey20" , },
        Folded = { fg="Black", bg="Grey40" , },
        StatusLine = { bg = "NONE", fg = "NONE" },
        -- ["Function"] = { link = "Special" },
        -- ["@function"] = { link = "Special" },
        ["@constructor"] = { link = "Special" },
        ["@type.qualifier"] = { fg="${cyan}" , style ="bold,italic"},
        ["@field"] = { fg="#D291BC" },
        ["@property"] = { fg="#8DA3B9" },
        -- ["@lsp"] = { fg="${red}" },
        ["@string"] = { fg="${green}" },
        ["PreProc"] = { fg="#815B5B" },
    },
    styles = { -- Choose from "bold,italic,underline"
        comments = "italic", -- Style that is applied to comments
        keywords = "bold,italic", -- Style that is applied to keywords
        constants = "bold,italic", -- Style that is applied to keywords
        functions = "italic", -- Style that is applied to functions
    },
    options = {
        cursorline = false, -- Use cursorline highlighting?
        transparency = false, -- Use a transparent background?
        terminal_colors = false, -- Use the colorscheme's colors for Neovim's :terminal?
        highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
    }
})
vim.o.background = "dark" -- to load onedark
vim.cmd("colorscheme onedark")  -- Lua

local links = {
  ['@lsp.mod.classScope.cpp'] = '',
  ['@lsp.typemod.property.classScope.cpp'] = '',
  ['@lsp.type.property.cpp'] = '',
  ['@lsp.type.namespace'] = '@namespace',
  ['@lsp.type.type'] = '@type',
  ['@lsp.type.class'] = '@type',
  ['@lsp.type.enum'] = '@type',
  ['@lsp.type.interface'] = '@type',
  ['@lsp.type.struct'] = '@structure',
  ['@lsp.type.parameter'] = '@parameter',
  ['@lsp.type.variable'] = '@variable',
  ['@lsp.type.enumMember'] = '@constant',
  ['@lsp.type.function'] = '@function',
  ['@lsp.type.method'] = '@method',
  ['@lsp.type.macro'] = '@macro',
  ['@lsp.type.decorator'] = '@function',
}
for newgroup, oldgroup in pairs(links) do
  vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
end
