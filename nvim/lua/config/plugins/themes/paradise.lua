local hlSet = require('config/options/utils').hlSet

local M = {}

M.colors = {
    base00 = "#151515",
    base01 = "#1F1F1F",
    base02 = "#2E2E2E",
    base03 = "#424242",
    base04 = "#BBB6B6",
    base05 = "#E8E3E3",
    base06 = "#E8E3E3",
    base07 = "#bbc2cf",
    base08 = "#B66467",
    base09 = "#ECBE7B",
    base0A = "#D9BC8C",
    base0B = "#8C977D",
    base0C = "#8AA6A2",
    base0D = "#8DA3B9",
    base0E = "#A988B0",
    base0F = "#BBB6B6",
}

M.theme = "paradise"
_G.theme = M.theme

M.setup = function() end

local present, base16 = pcall(require, "base16-colorscheme")
if not present then return end

local ok, err = pcall(cmd, ("colorscheme base16-" .. M.theme))
if not ok then
    base16.setup(M.colors)
    print("[Warn] (paradise): couldn't find paradise theme in base-16.\n", err)
end

-- -----------------------------------
-- Highlights
-- -----------------------------------
local color = M.colors

-- Status Line
hlSet("StatusNormal")
hlSet("StatusLineNC", {fg=color.base03})
hlSet("StatusActive", {fg=color.base05})
hlSet("StatusLine", {fg=color.base02}) -- inactive
hlSet("StatusReplace", {fg=color.base08})
hlSet("StatusInsert", {fg=color.base0B})
hlSet("StatusCommand", {fg=color.base0A})
hlSet("StatusVisual", {fg=color.base0D})
hlSet("StatusTerminal", {fg=color.base0E})
hlSet("Added", {fg=color.base0B})
hlSet("Removed", {fg=color.base08})
hlSet("Changed", {fg=color.base0D})

-- Treesitter
hlSet("TSParameter", {fg=color.base07})

-- Telescope
-- hlSet("TelescopePromptBorder", color.base01, color.base01)
-- hlSet("TelescopePromptNormal", nil, color.base01)
-- hlSet("TelescopePromptPrefix", color.base08, color.base01)
-- hlSet("TelescopeSelection", nil, color.base01)

-- Gitsigns
local present, _ = pcall(require, "gitsigns")
if present then
    hlSet("GitSignsAdd", {fg=color.base0B, bg=nil})
    hlSet("GitSignsChange", {fg=color.base03, bg=nil})
    hlSet("GitSignsDelete", {fg=color.base08, bg=nil})
    hlSet("GitSignsChangedelete", {fg=color.base08, bg=nil})
    hlSet("GitSignsTopdelete", {fg=color.base08, bg=nil})
    hlSet("GitSignsUntracked", {fg=color.base03, bg=nil})
end

-- Menu
hlSet("Pmenu", {fg=nil, bg=color.base01})
hlSet("PmenuSbar", {fg=nil, bg=color.base01})
hlSet("PmenuThumb", {fg=nil, bg=color.base01})
hlSet("PmenuSel", {fg=nil, bg=color.base02})

-- CMP
local present, _ = pcall(require, "nvim-cmp")
if present then
    hlSet("CmpItemAbbrMatch", {fg=color.base08})
    hlSet("CmpItemAbbrMatchFuzzy", {fg=color.base08})
    hlSet("CmpItemAbbr", {fg=color.base03})
    hlSet("CmpItemKind", {fg=color.base0E})
    hlSet("CmpItemMenu", {fg=color.base0E})
    hlSet("CmpItemKindSnippet", {fg=color.base0E})
end

-- Number
hlSet("CursorLine")
hlSet("CursorLineNR")
hlSet("LineNr", {fg=color.base03})

-- Others
hlSet("VertSplit", {fg=color.base01, bg=nil})
hlSet("WinSeparator", {fg=color.base01, bg=nil})
hlSet("NormalFloat", {fg=nil, bg=color.base01})
hlSet("FloatBorder", {fg=color.base01, bg=color.base01})

-- Extra
vim.cmd("hi StatusLine gui=strikethrough")
