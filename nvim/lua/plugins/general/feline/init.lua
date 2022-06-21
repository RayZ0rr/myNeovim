local has_feline, feline = pcall(require, 'feline')
if not has_feline then
  return
end

-- Reference:
-- 1) ibhagwan setup (https://github.com/ibhagwan/nvim-lua/blob/main/lua/plugins/feline.lua)
-- 2)  crivotz/nv-ide setup (https://github.com/crivotz/nv-ide/blob/master/lua/plugins/feline.lua)
-- 3) AstroNvim setup (https://github.com/AstroNvim/AstroNvim)

local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')

local force_inactive = {
  filetypes = {},
  buftypes = {},
  bufnames = {}
}

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

local vi_mode_text = {
  NORMAL = '<|',
  OP = '<|',
  INSERT = '|>',
  VISUAL = '<>',
  LINES = '<>',
  BLOCK = '<>',
  REPLACE = '<>',
  ['V-REPLACE'] = '<>',
  ENTER = '<>',
  MORE = '<>',
  SELECT = '<>',
  COMMAND = '<|',
  SHELL = '<|',
  TERM = '<|',
  NONE = '<>'
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

local file_osinfo = function()
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

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

local FullBar = function()
  return vim.api.nvim_win_get_width(0) > 75
end

local BarWidth = function(n)
  return function()
    return (vim.opt.laststatus:get() == 3 and vim.opt.columns:get() or vim.fn.winwidth(0)) > (n or 80)
  end
end

local function is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand '%:t') ~= 1
end

local checkwidth = function()
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
  'replacer',
  'fugitiveblame',
}

force_inactive.buftypes = {
  'terminal'
}

local bordersDecor = {
  left = {
    provider = '▊',
    hl = vimode_hl,
    right_sep = ' '
  },
  right = {
    provider = '▊',
    hl = vimode_hl,
    left_sep = ' '
  }
}

-- LEFT

-- vi-mode
components.active[1][1] = {
  provider = '▊',
  hl = vimode_hl,
  -- right_sep = ' '
}
components.active[1][2] = {
  -- provider = ' NV-IDE ',
  provider = function()
    -- return '  ' .. vi_mode_utils.get_vim_mode()
    return vi_mode_utils.get_vim_mode()
  end,
  hl = function()
    local val = {}
    val.name = vi_mode_utils.get_mode_highlight_name()
    val.fg = vi_mode_utils.get_mode_color()
    val.bg = 'black'
    val.style = 'bold'
    return val
  end,
  icon = {
    str = '  ',
    hl = vimode_hl,
  },
  right_sep = {
    str = ' ',
    hl = {
      fg = 'black',
      bg = 'black'
    }
  }
}

-- vi-mode
components.active[1][3] = {
  provider = '',
  hl = function()
    local val = {}

    val.fg = 'yellow'
    val.bg = 'black'
    -- val.style = 'bold'

    return val
  end,
}

-- vi-symbol
-- components.active[1][2] = {
  --   provider = function()
    --     return vi_mode_text[vi_mode_utils.get_vim_mode()]
    --   end,
    --   hl = function()
      --     local val = {}
      --     val.fg = vi_mode_utils.get_mode_color()
      --     val.bg = 'bg'
      --     val.style = 'bold'
      --     return val
      --   end,
      --   right_sep = ' '
  -- }

-- filename
components.active[1][4] = {
  provider = {
    name = 'file_info',
    colored_icon = true,
    opts = {
      type = 'unique-short'
    }
  },
  short_provider = 'file_type',
  icon = '',
  enabled = is_buffer_empty,
  hl = {
    fg = 'blue',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = " ",
  left_sep = " ",

}

components.active[1][5] = {
  provider = ' ',
  hl = {
    fg = 'yellow',
    bg = 'bg',
    style = 'bold'
  },
  -- right_sep = ' '
}

-- components.active[1][3] = {
  --   provider = function()
    --     return vim.fn.expand("%:F")
    --   end,
    --   hl = {
      --     bg = 'yellow',
      --     fg = 'bg',
      --     style = 'bold'
      --   },
      --   right_sep = ' '
      -- }

-- gitBranch
components.active[1][6] = {
  provider = 'git_branch',
  hl = {
    -- bg = 'yellow',
    fg = 'violet',
    style = 'bold'
  }
}
-- diffAdd
components.active[1][7] = {
  provider = 'git_diff_added',
  truncate_hide = true,
  enabled = FullBar,
  hl = {
    fg = 'green',
    bg = 'bg',
    style = 'bold'
  }
}
-- diffModfified
components.active[1][8] = {
  provider = 'git_diff_changed',
  truncate_hide = true,
  enabled = FullBar,
  hl = {
    fg = 'orange',
    bg = 'bg',
    style = 'bold'
  }
}
-- diffRemove
components.active[1][9] = {
  provider = 'git_diff_removed',
  truncate_hide = true,
  enabled = FullBar,
  hl = {
    fg = 'red',
    bg = 'bg',
    style = 'bold'
  }
}

-- MID

-- LspName
components.active[2][1] = {
  provider = 'lsp_client_names',
  hl = {
    fg = 'yellow',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}
-- diagnosticErrors
components.active[2][2] = {
  provider = 'diagnostic_errors',
  -- enabled = function() return lsp.diagnostics_exist('Error') end,
  enabled = require('feline.providers.lsp').diagnostics_exist(vim.diagnostic.severity.ERROR),
  hl = {
    fg = 'red',
    style = 'bold'
  }
}
-- diagnosticWarn
components.active[2][3] = {
  provider = 'diagnostic_warnings',
  truncate_hide = true,
  enabled = require('feline.providers.lsp').diagnostics_exist(vim.diagnostic.severity.WARN),
  hl = {
    fg = 'yellow',
    style = 'bold'
  }
}
-- diagnosticHint
components.active[2][4] = {
  provider = 'diagnostic_hints',
  truncate_hide = true,
  enabled = require('feline.providers.lsp').diagnostics_exist(vim.diagnostic.severity.HINT),
  hl = {
    fg = 'cyan',
    style = 'bold'
  }
}
-- diagnosticInfo
components.active[2][5] = {
  provider = 'diagnostic_info',
  truncate_hide = true,
  enabled = require('feline.providers.lsp').diagnostics_exist(vim.diagnostic.severity.INFO),
  hl = {
    fg = 'skyblue',
    style = 'bold'
  }
}
-- Treesitter status
components.active[2][6] = {
  provider = TreesitterStatus,
  enabled = BarWidth,
  hl = {
    fg = 'skyblue',
    style = 'bold'
  }
}

-- RIGHT
-- fileIcon
components.active[3][1] = {
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
}

-- fileType
components.active[3][2] = {
  provider = 'file_type',
  enabled = FullBar,
  hl = function()
    local val = {}
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
}
-- lineInfo
components.active[3][3] = {
  provider = LinesInfo,
  -- provider = 'position',
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}
-- linePercent
components.active[3][4] = {
  provider = 'line_percentage',
  enabled = FullBar,
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}
-- scrollBar
components.active[3][5] = {
  provider = 'scroll_bar',
  enabled = FullBar,
  right_sep = ' ',
  hl = {
    fg = 'magenta',
    style = 'bold'
  }
}
-- fileSize
components.active[3][6] = {
  provider = 'file_size',
  enabled = FullBar,
  hl = {
    fg = 'skyblue',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}
-- fileFormat
components.active[3][7] = {
  provider = file_osinfo,
  enabled = FullBar,
  hl = function()
    local val = {}

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
}
-- fileEncode
components.active[3][8] = {
  provider = 'file_encoding',
  -- enabled = FullBar,
  hl = function()
    local val = {}

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
  -- right_sep = ' '
}

components.active[3][9] = bordersDecor.right

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
    bg = 'NONE',
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
