local hlSet = require('config/options/utils').hlSet

local colors = {
    darkgrey = "#2E2E2E",
    grey = "#424242",
    grey_dark1='#424242',
    grey_dark2='#2E2E2E',
    grey_dark3='#262A31',
    grey_cool='#B1B8C5',
    black_light1='#1F2228',
    black_light2='#1A1D22',
    black_light3='#202328',
    black = "#151515",
    white_dark = "#E8E3E3",
    white = "#FFFFFF",
    red = "#B66467",
    yellow = "#D9BC8C",
    green = "#8C977D",
    teal = "#8AA6A2",
    blue = "#8DA3B9",
    purple = "#A988B0",
    ash = "#BBB6B6",
    fg = "#BBB6B6",
    bg = "#1F1F1F",
}

hlSet("FzfLuaNormal", {fg = colors.white, bg = colors.black_light1})
hlSet("FzfLuaBorder", {fg = colors.white, bg = colors.bg})
hlSet("FzfLuaTitle", {fg = colors.black, bg = colors.red})
hlSet("FzfLuaTitleFlags", {fg = colors.white, bg = colors.red})
hlSet("FzfLuaBackdrop", {fg = colors.red, bg = colors.red})
hlSet("FzfLuaPreviewNormal", {fg = colors.green, bg = colors.black_light2})
hlSet("FzfLuaPreviewBorder", {fg = colors.black_light2, bg = colors.black_light2})
hlSet("FzfLuaPreviewTitle", {fg = colors.bg, bg = colors.green})
hlSet("FzfLuaCursor", {fg = colors.red, bg = colors.grey})
hlSet("FzfLuaCursorLine", {fg = nil, bg = colors.grey})
hlSet("FzfLuaCursorLineNr", {fg = colors.red, bg = colors.grey})
hlSet("FzfLuaSearch", {fg = colors.red, bg = colors.grey})
-- hlSet("FzfLuaScrollBorderEmpty", {fg = colors.green, bg = colors.bg})
-- hlSet("FzfLuaScrollBorderFull", {fg = colors.green, bg = colors.bg})
-- hlSet("FzfLuaScrollFloatEmpty", {fg = colors.green, bg = colors.bg})
-- hlSet("FzfLuaScrollFloatFull", {fg = colors.green, bg = colors.bg})
-- hlSet("FzfLuaHelpNormal", {fg = colors.green, bg = colors.bg})
-- hlSet("FzfLuaHelpBorder", {fg = colors.green, bg = colors.bg})
-- hlSet("FzfLuaHeaderBind", {fg = colors.green, bg = colors.bg})
-- hlSet("FzfLuaHeaderText", {fg = colors.green, bg = colors.bg})
-- hlSet("FzfLuaPathColNr", {fg = colors.green, bg = colors.bg})
-- hlSet("FzfLuaPathLineNr", {fg = colors.green, bg = colors.bg})
-- hlSet("FzfLuaBufName", {fg = colors.green, bg = colors.bg})
-- hlSet("FzfLuaBufId", {fg = colors.green, bg = colors.bg})
-- hlSet("FzfLuaBufNr", {fg = colors.green, bg = colors.bg})
-- hlSet("FzfLuaBufLineNr", {fg = colors.green, bg = colors.bg})
-- hlSet("FzfLuaBufFlagCur", {fg = colors.green, bg = colors.bg})
-- hlSet("FzfLuaBufFlagAlt", {fg = colors.green, bg = colors.bg})
-- hlSet("FzfLuaTabTitle", {fg = colors.green, bg = colors.bg})
-- hlSet("FzfLuaTabMarker", {fg = colors.green, bg = colors.bg})
-- hlSet("FzfLuaDirIcon", {fg = nil, bg = nil})
hlSet("FzfLuaDirPart", {fg = colors.yellow, bg = nil})
hlSet("FzfLuaFilePart", {fg = colors.blue, bg = nil})
hlSet("FzfLuaLivePrompt", {fg = colors.red})
hlSet("FzfLuaLiveSym", {fg = colors.blue})
hlSet("FzfLuaFzfMatch", {fg = colors.purple})

-- hlSet("FzfLuaNormal", {fg = nil, bg = nil})
-- hlSet("FzfLuaBorder", {fg = nil, bg = nil})
-- hlSet("FzfLuaTitle", {fg = nil, bg = nil})
-- hlSet("FzfLuaTitleFlags", {fg = nil, bg = nil})
-- hlSet("FzfLuaBackdrop", {fg = nil, bg = nil})
-- hlSet("FzfLuaPreviewNormal", {fg = nil, bg = nil})
-- hlSet("FzfLuaPreviewBorder", {fg = nil, bg = nil})
-- hlSet("FzfLuaPreviewTitle", {fg = nil, bg = nil})
-- hlSet("FzfLuaCursor", {fg = nil, bg = nil})
-- hlSet("FzfLuaCursorLine", {fg = nil, bg = nil})
-- hlSet("FzfLuaCursorLineNr", {fg = nil, bg = nil})
-- hlSet("FzfLuaSearch", {fg = nil, bg = nil})
