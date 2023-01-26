local status_ok, heirline = pcall(require, "heirline")
if not status_ok then
  return
end

local utils = require("heirline.utils")

local StatusLine = require("plugins/general/statusline/heirline/statusline")
local TabLine = require("plugins/general/statusline/heirline/buffertabline")

local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  skyblue = '#7daea3',
  blue     = '#51afef',
  oceanblue = '#45707a',
  darkblue = '#081633',
  red      = '#ec5f67',
  cream = '#a89984',
  white       = '#ffffff',
  black       = '#202328',
  grey       = '#bbc2cf',
  bright_fg = utils.get_highlight("Folded").fg,
  red = utils.get_highlight("DiagnosticError").fg,
  dark_red = utils.get_highlight("DiffDelete").bg,
  green = utils.get_highlight("String").fg,
  blue = utils.get_highlight("Function").fg,
  gray = utils.get_highlight("NonText").fg,
  orange = utils.get_highlight("Constant").fg,
  purple = utils.get_highlight("Statement").fg,
  cyan = utils.get_highlight("Special").fg,
  diag_warn = utils.get_highlight("DiagnosticWarn").fg,
  diag_error = utils.get_highlight("DiagnosticError").fg,
  diag_hint = utils.get_highlight("DiagnosticHint").fg,
  diag_info = utils.get_highlight("DiagnosticInfo").fg,
  git_del = utils.get_highlight("diffRemoved").fg,
  git_add = utils.get_highlight("diffAdded").fg,
  git_change = utils.get_highlight("diffChanged").fg,
}

-- require('heirline').load_colors(setup_colors())
require('heirline').load_colors(colors)
require("heirline").setup({statusline = StatusLine,winbar = nil,tabline = TabLine})
