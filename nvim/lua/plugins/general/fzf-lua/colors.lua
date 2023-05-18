local function hl(highlight, fg, bg, link)
  if fg == nil then fg = "none" end
  if bg == nil then bg = "none" end
  vim.api.nvim_set_hl(0, highlight, { fg = fg, bg = bg})
  if link ~= nil then
    vim.api.nvim_set_hl(0, highlight, { link = link })
  end
end

local colors = {
  fg = "#BBB6B6",
  bg = "#1F1F1F",
  black = "#151515",
  darkgrey = "#2E2E2E",
  grey = "#424242",
  darkwhite = "#E8E3E3",
  white = "#E8E3E3",
  red = "#B66467",
  yellow = "#D9BC8C",
  green = "#8C977D",
  teal = "#8AA6A2",
  blue = "#8DA3B9",
  purple = "#A988B0",
  ash = "#BBB6B6",
}

hl("FzfLuaNormal", colors.darkwhite, colors.bg)
hl("FzfLuaBorder", colors.red, colors.bg)
hl("FzfLuaCursorLine", colors.green, colors.bg)
hl("FzfLuaCursorLineNr", colors.yellow, colors.bg)
hl("FzfLuaSearch", colors.yellow, colors.green)
hl("FzfLuaTitle", colors.black, colors.red)
hl("FzfLuaScrollBorderEmpty", nil, colors.red)
hl("FzfLuaScrollBorderFull", nil, colors.red)
hl("FzfLuaScrollFloatEmpty", nil, colors.red)
hl("FzfLuaScrollFloatFull", nil, colors.red)
hl("FzfLuaHelpNormal", colors.darkgrey, colors.green)
hl("FzfLuaHelpBorder", colors.green, colors.red)
