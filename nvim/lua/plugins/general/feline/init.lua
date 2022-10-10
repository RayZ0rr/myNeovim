local has_feline, feline = pcall(require, 'feline')
if not has_feline then
  return
end

local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')

local force_inactive = {
  filetypes = {},
  buftypes = {},
  bufnames = {}
}

-- Three sections for active statusbar and three for inactive
local components = {
  active = {{}, {}, {}},
  inactive = {{}, {}, {}},
}

local my_theme = {
  bg = '#282828',
  black = '#282828',
  yellow = '#d8a657',
  cyan = '#89b482',
  oceanblue = '#45707a',
  green = '#a9b665',
  orange = '#e78a4e',
  violet = '#d3869b',
  magenta = '#D16D9E',
  white = '#a89984',
  fg = '#a89984',
  skyblue = '#7daea3',
  red = '#ea6962',
  blue = '#61afef',
}

local vi_mode_colors = {
  NORMAL = 'green',
  OP = 'green',
  INSERT = 'red',
  VISUAL = 'magenta',
  LINES = 'magenta',
  BLOCK = 'magenta',
  REPLACE = 'violet',
  ['V-REPLACE'] = 'violet',
  ENTER = 'cyan',
  MORE = 'cyan',
  SELECT = 'orange',
  COMMAND = 'green',
  SHELL = 'green',
  TERM = 'green',
  NONE = 'yellow'
}

local icons = {
  linux = ' ',
  macos = ' ',
  windows = ' ',

  errs = ' ',
  warns = ' ',
  infos = ' ',
  hints = ' ',

  lsp = ' ',
  git = ''
}

local OSinfo = function()
  local os = vim.bo.fileformat:upper()
  local icon
  if os == 'UNIX' then
    icon = icons.linux
  elseif os == 'MAC' then
    icon = icons.macos
  else
    icon = icons.windows
  end
  return icon .. os
end

local LinesInfo = function()
  local line = vim.fn.line('.')
  local column = vim.fn.col('.')
  local total_line = vim.fn.line('$')
  return string.format("%d:%d  %d", column, line, total_line)
end

local TreesitterStatus = function()
  local ts = vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()]
  return (ts and next(ts)) and " 綠TS" or ""
end

local BufferNotEmpty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

local FullBar = function()
  return vim.api.nvim_win_get_width(0) > 95
end

local BarWidth = function(n)
  return (vim.opt.laststatus:get() == 3 and vim.opt.columns:get() or vim.fn.winwidth(0)) > (n or 80)
end

local function BufferEmpty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand '%:t') ~= 1
end

local CheckWidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

local function vimode_hl()
  return {
    name = vi_mode_utils.get_mode_highlight_name(),
    fg = vi_mode_utils.get_mode_color()
  }
end

force_inactive.filetypes = {
  'NvimTree',
  'fern',
  'dbui',
  'packer',
  'startify',
  'fugitive',
  'term',
  'toggleterm',
  'fm',
  'fzf',
  'replacer',
  'fugitiveblame',
}

force_inactive.buftypes = {
  'terminal'
}

local Borders = {
  left = {
    name = 'LeftBar',
    provider = '▊',
    hl = function()
      local val = {}
      val.name = 'Status_LeftBar'
      val.fg = vi_mode_utils.get_mode_color()
      val.style = 'bold'
      return val
    end,
  },
  right = {
    name = 'RightBar',
    provider = '▊',
    hl = function()
      local val = {}
      val.name = 'Status_RightBar'
      val.fg = vi_mode_utils.get_mode_color()
      val.style = 'bold'
      return val
    end,
    left_sep = " "
  }
}

---------------------------------------------
-- LEFT
---------------------------------------------

table.insert(components.active[1], Borders.left)
-- vi-mode
table.insert(components.active[1], {
  name = 'VimMode',
  -- provider = function()
  --   return vi_mode_utils.get_vim_mode()
  -- end,
  -- provider = 'vi_mode',
  provider = '  ',
  hl = function()
    local val = {}
    val.name = vi_mode_utils.get_mode_highlight_name()
    val.fg = vi_mode_utils.get_mode_color()
    val.bg = 'black'
    val.style = 'bold'
    return val
  end,
  right_sep = " "
})

table.insert(components.active[1], {
  name = 'FileSepLeft',
  -- provider = '',
  provider = '(',
  hl = function()
    local val = {}
    val.name = 'Status_FileSep'
    val.fg = 'yellow'
    val.bg = 'black'
    return val
  end,
})
-- filename
table.insert(components.active[1], {
  name = 'FileInfo',
  provider = {
    name = 'file_info',
    colored_icon = true,
    opts = {
      type = 'unique-short'
    }
  },
  short_provider = 'file_type',
  hl = {
    name = 'Status_FileInfo',
    fg = 'blue',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = " ",
  left_sep = " ",
})

table.insert(components.active[1], {
  name = 'FileSepRight',
  -- provider = ' ',
  provider = ')',
  hl = {
    name = 'Status_FileSep',
    fg = 'yellow',
    bg = 'bg',
    style = 'bold'
  },
})

-- gitBranch
table.insert(components.active[1], {
  name = 'GitBranch',
  provider = 'git_branch',
  hl = {
    name = 'Status_GitBranch',
    fg = 'violet',
    style = 'bold'
  }
})

-- diffAdd
table.insert(components.active[1], {
  name = 'GitDiffAdd',
  provider = 'git_diff_added',
  truncate_hide = true,
  hl = {
    name = 'Status_GitDiffAdd',
    fg = 'green',
    bg = 'bg',
    style = 'bold'
  }
})

-- diffModfified
table.insert(components.active[1], {
  name = 'GitDiffMod',
  provider = 'git_diff_changed',
  truncate_hide = true,
  hl = {
    name = 'Status_GitDiffMod',
    fg = 'orange',
    bg = 'bg',
    style = 'bold'
  }
})

-- diffRemove
table.insert(components.active[1], {
  name = 'GitDiffRem',
  provider = 'git_diff_removed',
  truncate_hide = true,
  hl = {
    name = 'Status_GitDiffRem',
    fg = 'red',
    bg = 'bg',
    style = 'bold'
  }
})

---------------------------------------------
-- MID
---------------------------------------------

-- LspName
table.insert(components.active[2], {
  name = 'LspClient',
  provider = 'lsp_client_names',
  hl = {
    name = 'Status_Lsp',
    fg = 'yellow',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
})
-- diagnosticErrors
table.insert(components.active[2], {
  name = 'DiagErr',
  provider = 'diagnostic_errors',
  enabled = require('feline.providers.lsp').diagnostics_exist(vim.diagnostic.severity.ERROR),
  hl = {
    name = 'Status_DiagErr',
    fg = 'red',
    style = 'bold'
  }
})
-- diagnosticWarn
table.insert(components.active[2], {
  name = 'DiagWarn',
  provider = 'diagnostic_warnings',
  truncate_hide = true,
  enabled = require('feline.providers.lsp').diagnostics_exist(vim.diagnostic.severity.WARN),
  hl = {
    name = 'Status_DiagWarn',
    fg = 'yellow',
    style = 'bold'
  }
})
-- diagnosticHint
table.insert(components.active[2], {
  name = 'DiagHint',
  provider = 'diagnostic_hints',
  truncate_hide = true,
  enabled = require('feline.providers.lsp').diagnostics_exist(vim.diagnostic.severity.HINT),
  hl = {
    name = 'Status_DiagHint',
    fg = 'cyan',
    style = 'bold'
  }
})
-- diagnosticInfo
table.insert(components.active[2], {
  name = 'DiagInfo',
  provider = 'diagnostic_info',
  truncate_hide = true,
  enabled = require('feline.providers.lsp').diagnostics_exist(vim.diagnostic.severity.INFO),
  hl = {
    name = 'Status_DiagInfo',
    fg = 'skyblue',
    style = 'bold'
  }
})
-- Treesitter status
table.insert(components.active[2], {
  name = 'Treesitter',
  provider = TreesitterStatus,
  hl = {
    name = 'Status_Treesitter',
    fg = 'skyblue',
    style = 'bold'
  }
})

---------------------------------------------
-- RIGHT
---------------------------------------------

-- fileIcon
table.insert(components.active[3], {
  name = 'FileIcon',
  provider = function()
    local filename = vim.fn.expand('%:t')
    local extension = vim.fn.expand('%:e')
    local icon  = require'nvim-web-devicons'.get_icon(filename, extension)
    if icon == nil then
      icon = ''
    end
    return icon
  end,
  -- enabled = FullBar,
  hl = function()
    local val = {}
    val.name = 'Status_FileIcon'
    local filename = vim.fn.expand('%:t')
    local extension = vim.fn.expand('%:e')
    local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
    if icon ~= nil then
      val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
    else
      val.fg = 'white'
    end
    val.bg = 'bg'
    val.style = 'bold'
    return val
  end,
  right_sep = ' '
})

-- fileType
table.insert(components.active[3], {
  name = 'FileType',
  provider = 'file_type',
  hl = function()
    local val = {}
    val.name = 'Status_FileType'
    local filename = vim.fn.expand('%:t')
    local extension = vim.fn.expand('%:e')
    local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
    if icon ~= nil then
      val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
    else
      val.fg = 'white'
    end
    val.bg = 'bg'
    val.style = 'bold'
    return val
  end,
  right_sep = ' '
})
-- lineInfo
table.insert(components.active[3], {
  name = 'LinesInfo',
  provider = LinesInfo,
  truncate_hide = true,
  hl = {
    name = 'Status_LinesInfo',
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
})
-- linePercent
table.insert(components.active[3], {
  name = 'LinePerc',
  provider = 'line_percentage',
  truncate_hide = true,
  hl = {
    name = 'Status_LinesPerc',
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
})
-- scrollBar
table.insert(components.active[3], {
  name = 'ScrollBar',
  provider = 'scroll_bar',
  truncate_hide = true,
  right_sep = ' ',
  hl = {
    name = 'Status_ScrollBar',
    fg = 'magenta',
    style = 'bold'
  }
})
-- fileSize
table.insert(components.active[3], {
  name = 'FileSize',
  provider = 'file_size',
  truncate_hide = true,
  hl = {
    name = 'Status_FileSize',
    fg = 'skyblue',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
})
-- fileFormat
table.insert(components.active[3], {
  name = 'FileFormat',
  provider = OSinfo,
  truncate_hide = true,
  hl = function()
    local val = {}
    val.name = 'Status_FileFormat'
    val.fg = vi_mode_utils.get_mode_color()
    val.bg = 'black'
    val.style = 'bold'
    return val
  end,
  --    hl = {
    -- fg = 'white',
    -- bg = 'bg',
    -- style = 'bold'
    --    },
  right_sep = ' '
})
-- fileEncode
table.insert(components.active[3], {
  name = 'FileEncode',
  provider = 'file_encoding',
  truncate_hide = true,
  hl = function()
    local val = {}
    val.name = 'Status_FileEncode'
    val.fg = vi_mode_utils.get_mode_color()
    val.bg = 'black'
    val.style = 'bold'
    return val
  end,
})

table.insert(components.active[3], Borders.right)

-- INACTIVE

-- fileType
components.inactive[1][1] = {
  provider = '' ,
  hl = {
    fg = 'red',
    bg = 'black',
    style = 'bold'
  },
  left_sep = {
    str = ' ',
    hl = {
      fg = 'black',
      bg = 'black'
    }
  },
  right_sep = {
    str = ' -> ',
    hl = {
      fg = 'yellow',
      bg = 'black'
    },
  }
}
components.inactive[1][2] = {
  provider = function()
    return vi_mode_utils.get_vim_mode()
  end,
  hl = function()
    local val = {}
    val.name = vi_mode_utils.get_mode_highlight_name()
    val.fg = 'blue'
    val.bg = 'black'
    val.style = 'bold'
    return val
  end,
  right_sep = {
    str = ' ',
    hl = {
      fg = 'black',
      bg = 'black'
    },
  }
}

components.inactive[1][3] = {
  provider = '',
  hl = function()
    local val = {}

    val.fg = 'cyan'
    val.bg = 'black'
    val.style = 'bold'

    return val
  end,
}

-- filetype
components.inactive[1][4] = {
  provider = 'file_type',
  hl = {
    fg = 'yellow',
    bg = 'NONE',
  },
  left_sep = {
    str = ' FT : ',
    hl = {
      fg = 'yellow',
      bg = 'NONE'
    }
  },
  right_sep = {
    {
      str = ' ',
      hl = {
        fg = 'cyan',
        bg = 'NONE',
      }
    },
  }
}

components.inactive[1][5] = {
  provider = ' ',
  hl = {
    fg = 'cyan',
    bg = 'black',
    style = 'bold'
  },
}

components.inactive[1][6] = {
  provider = ' ',
  hl = {
    fg = 'red',
    bg = 'black',
    style = 'bold'
  },
}

components.inactive[2][1] = {
  provider = "Code Status:" .. '%{g:asyncrun_status}',
  enabled = function()
    return vim.g.asyncrun_status ~= nil and vim.bo.filetype == 'qf'
  end,
  hl = {
    fg = 'black',
    bg = 'cyan',
    style = 'bold'
  },
  left_sep = {
    str = ' ',
    hl = {
      fg = 'NONE',
      bg = 'cyan'
    }
  },
  right_sep = {
    {
      str = ' ',
      hl = {
	fg = 'NONE',
	bg = 'cyan'
      }
    },
  }
}

-- require('feline').use_theme(my_theme)
require('feline').setup{
  theme = my_theme,
  -- theme = 'onedark',
  components = components,
  vi_mode_colors = vi_mode_colors,
  force_inactive = force_inactive,
}
