local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end
local utils = require('plugins.general.statusline.utils')

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
  white = '#a89984',
  black       = '#202328',
  grey       = '#bbc2cf',
}

local mode_color = {
  n = colors.green,
  i = colors.red,
  v = colors.magenta,
  [''] = colors.blue,
  V = colors.blue,
  c = colors.magenta,
  no = colors.green,
  s = colors.orange,
  S = colors.orange,
  [''] = colors.orange,
  ic = colors.yellow,
  R = colors.violet,
  Rv = colors.violet,
  cv = colors.red,
  ce = colors.red,
  r = colors.cyan,
  rm = colors.cyan,
  ['r?'] = colors.cyan,
  ['!'] = colors.red,
  t = colors.red,
}

local function vimode_hl()
  return mode_color[vim.fn.mode()]
end

-- Config
local config = {
  options = {
    theme = 'auto',
    icons_enabled = true,
    always_divide_middle = true,
    globalstatus = false,
    component_separators = '',
    section_separators = '',
    padding = { left = 0, right = 0 },
    -- ignore_focus = {
    --   'NvimTree',
    --   'netrw',
    --   'fern',
    --   'alpha',
    --   'dashboard',
    --   'dbui',
    --   'packer',
    --   'startify',
    --   'fugitive',
    --   'term',
    --   'floaterm',
    --   'toggleterm',
    --   'fm',
    --   'qf',
    --   'fzf',
    --   'replacer',
    --   'fugitiveblame',
    -- }
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {'filename'},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
    lualine_a = {
    {
      'buffers',
      mode=4,
      buffers_color= {active={fg=colors.blue,bg=''}, inactive = {fg='grey',bg=''}},
      separator = { left = { '|',fg=colors.blue,bg=''} , right = ' L' }
    }
    },
    lualine_z = {'tabs'}
  },
  extensions = {quickfix},
}

table.insert(config.sections.lualine_a, {
  function()
    return '▊'
  end,
  color = function()
    -- auto change color according to neovims mode
    return { fg = vimode_hl(), bg = colors.bg }
  end,
  padding = { left = 0, right = 0 },
})
table.insert(config.sections.lualine_a, {
  -- mode component
  function()
    local mode = "["..string.upper(vim.fn.mode(1)).."]"
    return " "..mode
    -- return ' ' .. vim.fn.mode(0)
  end,
  color = function()
    return { fg = vimode_hl(), bg = colors.bg, gui = 'bold' }
  end,
  separator = {left = 'test'},
  padding = { left = 1, right = 1 },
})

table.insert(config.sections.lualine_a, {
  function()
    return ''
    -- return '('
  end,
  color = function()
    local val = {}
    val.fg = colors.yellow
    val.bg = colors.bg
    return val
  end,
})
table.insert(config.sections.lualine_a, {
  'filename',
  cond = utils.Conditions.BufferNotEmpty,
  color = { fg = colors.blue, bg=colors.bg, gui = 'bold' },
  padding = { left = 1, right = 1 },
})
table.insert(config.sections.lualine_a, {
  function()
    return ''
    -- return '('
  end,
  color = function()
    local val = {}
    val.fg = colors.yellow
    val.bg = colors.bg
    return val
  end,
  padding = { right = 1 },
})

table.insert(config.sections.lualine_b, {
  'branch',
  -- icon = '',
  color = { fg = colors.violet, bg=colors.bg, gui = 'bold' },
  fmt=utils.Functions.Truncate(80, 6, 60, false),
  cond = utils.Conditions.FullBar,
})

table.insert(config.sections.lualine_b, {
  'diff',
  symbols = { added = ' ', modified = '柳 ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = utils.Conditions.FullBar,
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
table.insert(config.sections.lualine_c, {
  function()
    return '%='
  end,
  color = { fg = colors.skyblue, bg = colors.bg },
})
table.insert(config.sections.lualine_c, {
  -- Lsp server name .
  utils.Functions.LSPStatus,
  cond = utils.Conditions.CheckLSP,
  icon = ' ',
  color = { fg = colors.yellow, bg = colors.bg },
})
table.insert(config.sections.lualine_c, {
  -- Treesitter Status .
  utils.Functions.TreesitterStatus,
  color = { fg = colors.skyblue, bg = colors.bg },
})

-- Add components to right sections
table.insert(config.sections.lualine_x, {
  'diagnostics',
  fmt=utils.Functions.Truncate(80, 8, 60, true),
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
  cond = utils.Conditions.FullBar,
  color = { bg = colors.bg },
  padding = { right = 1 },
})
table.insert(config.sections.lualine_x, {
  'filetype',
  fmt = string.upper,
  cond = utils.Conditions.FullBar,
  color = function()
    local val = {}
    local filename = vim.fn.expand('%:t')
    local extension = vim.fn.expand('%:e')
    local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
    if icon ~= nil then
      val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
    else
      val.fg = colors.magenta
    end
    val.bg = colors.bg
    val.gui = 'bold'
    return val
  end,
  padding = { left = 1, right = 1 },
})

table.insert(config.sections.lualine_y, {
  utils.Functions.LinesInfo,
  fmt = string.upper,
  cond = utils.Conditions.FullBar,
  color = function()
    local val = {}
    local filename = vim.fn.expand('%:t')
    local extension = vim.fn.expand('%:e')
    local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
    if icon ~= nil then
      val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
    else
      val.fg = colors.magenta
    end
    val.bg = colors.bg
    return val
  end,
  color = { fg = colors.orange, bg = colors.bg },
  padding = { left = 1, right = 1 },
})
table.insert(config.sections.lualine_y, {
  utils.Functions.ScrollBar,
  cond = utils.Conditions.FullBar,
  color = function()
    return { fg = colors.violet, bg = colors.darkblue }
  end,
})
table.insert(config.sections.lualine_z, {
  'o:encoding', -- option component same as &encoding in viml
  fmt = string.upper,
  cond = utils.Conditions.FullBar,
  color = function()
    return { fg = colors.magenta, bg = colors.bg }
  end,
  padding = {left = 1},
})
table.insert(config.sections.lualine_z, {
  'fileformat',
  fmt = string.upper,
  icons_enabled = true,
  color = function()
    return { fg = vimode_hl(), bg = colors.bg }
  end,
  cond = utils.Conditions.FullBar,
  padding = { left = 1, right = 1 },
})
table.insert(config.sections.lualine_z, {
  function()
    return '▊'
  end,
  color = function()
    return { fg = vimode_hl(), bg = colors.bg }
  end,
  padding = { left = 1 },
})

table.insert(config.inactive_sections.lualine_a, {
  function()
    return ''
  end,
  color = {
    fg = colors.red,
    bg = colors.black,
    gui = 'bold'
  },
  padding = {
    left = 1,
  },
})
table.insert(config.inactive_sections.lualine_a, {
  function()
    return ' -> '
  end,
  color = {
    fg = colors.yellow,
    bg = colors.black,
    gui = 'bold'
  },
})
table.insert(config.inactive_sections.lualine_a, {
  function()
    return vim.fn.mode().." "
  end,
  fmt = string.upper,
  color = function()
    local val = {}
    val.fg = colors.blue
    val.bg = colors.black
    val.gui = 'bold'
    return val
  end,
})
table.insert(config.inactive_sections.lualine_a, {
  function()
    return ''
  end,
  color = function()
    local val = {}
    val.fg = colors.cyan
    val.bg = colors.black
    val.gui = 'bold'
    return val
  end,
})
table.insert(config.inactive_sections.lualine_b, {
  function()
    return 'FT :'
  end,
  cond = utils.Conditions.BufferNotEmpty,
  color = { fg = colors.yellow, bg=colors.bg},
  padding = { left = 1, right = 1 },
})
table.insert(config.inactive_sections.lualine_b, {
  'filename',
  cond = utils.Conditions.BufferNotEmpty,
  color = { fg = colors.yellow, bg=colors.bg},
  padding = { left = 1, right = 1 },
})
table.insert(config.inactive_sections.lualine_b, {
  function()
    return ''
  end,
  color = function()
    local val = {}
    val.fg = colors.cyan
    val.bg = colors.black
    val.gui = 'bold'
    return val
  end,
})

table.insert(config.inactive_sections.lualine_x, {
  function()
    return ' '
  end,
  color = function()
    local val = {}
    val.fg = colors.red
    val.bg = colors.black
    val.gui = 'bold'
    return val
  end,
})
table.insert(config.inactive_sections.lualine_x, {
  function()
    return ' '
  end,
  color = function()
    local val = {}
    val.fg = colors.red
    val.bg = colors.black
    val.gui = 'bold'
    return val
  end,
})
table.insert(config.inactive_sections.lualine_x, {
  function()
    return "Code Status:" .. '%{g:asyncrun_status}'
  end,
  -- cond = function()
  --   return vim.g.asyncrun_status ~= nil and vim.bo.filetype == 'qf'
  -- end,
  color = function()
    local val = {}
    val.fg = colors.red
    -- val.bg = colors.black
    val.gui = 'bold'
    return val
  end,
  separator = {
    left = ' ',
    right = ' ',
  }
})
-- Now don't forget to initialize lualine
lualine.setup(config)
