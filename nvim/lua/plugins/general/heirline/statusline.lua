local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local myUtils = require('plugins.general.statusline.utils')

local mode_colors = {
  n = 'green',
  i = 'red',
  v = 'magenta',
  [''] = 'blue',
  V = 'blue',
  c = 'magenta',
  no = 'green',
  s = 'orange',
  S = 'orange',
  [''] = 'orange',
  ic = 'yellow',
  R = 'violet',
  Rv = 'violet',
  cv = 'red',
  ce = 'red',
  r = 'cyan',
  rm = 'cyan',
  ['r?'] = 'cyan',
  ['!'] = 'red',
  t = 'red',
}

special_filetypes = {
  'NvimTree',
  'netrw',
  'qf',
  'fern',
  'dbui',
  'packer',
  'fugitive',
  'term',
  'floaterm',
  'toggleterm',
  'fm',
  'fzf',
  'replacer',
  'fugitiveblame',
}

--------------------------------------------------
-- Components
--------------------------------------------------
local function vimode_hl()
  return mode_colors[vim.fn.mode()]
end
local SideBar = {
  provider = function()
    return '▊'
  end,
  hl = function()
    -- auto change color according to neovims mode
    return { fg = vimode_hl() }
  end,
}
local ViMode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
    if not self.once then
      vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = "*:*o",
	command = 'redrawstatus'
      })
      self.once = true
    end
  end,
  {
  provider = function(self)
    return "  "
    -- local mode = "["..string.upper(vim.fn.mode(1)).."]"
    -- return " "..mode
  end,
  hl = function(self)
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    return { fg = 'bg', bg = mode_colors[mode], bold = true, }
  end,
  },
  {
  provider = function(self)
    return " %2(["..myUtils.Vars.mode_names[self.mode].."%)]"
  end,
  hl = function(self)
    local mode = self.mode:sub(1, 1)
    return { fg = mode_colors[mode], bold = true, }
  end,
  }
}
local OSMode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
  end,
  {
  provider = function(self)
    local os = vim.bo.fileformat:upper()
    return os.." "
  end,
  hl = function(self)
    local mode = self.mode:sub(1, 1)
    return { fg = mode_colors[mode], bold = true, }
  end,
  },
  {
  provider = myUtils.Functions.OSicon,
  hl = function(self)
    local mode = self.mode:sub(1, 1)
    return { fg = 'bg', bg = mode_colors[mode], bold = true, }
  end,
  },
}
local Left_filebar = {
  provider = function(self)
    return ''
    -- return '('
  end,
  hl = function(self)
    local val = {}
    val.fg = 'yellow'
    return val
  end,
}
local FileNameBlock = {
  condition = myUtils.Conditions.BufferNotEmpty,
  -- let's first set up some attributes needed by this component and it's children
  init = function(self)
      self.filename = vim.api.nvim_buf_get_name(0)
  end,
}
-- local FileName = {
--   provider = function(self)
--     local filename = vim.fn.fnamemodify(self.filename, ":.")
--     if filename == "" then return "[No Name]" end
--     if not conditions.width_percent_below(#filename, 0.25) then
--       filename = vim.fn.pathshorten(filename)
--     end
--     return filename
--   end,
--   hl = { fg = utils.get_highlight("Directory").fg },
-- }
local FileName = {
  init = function(self)
    self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
    if self.lfilename == "" then self.lfilename = "[No Name]" end
  end,
  hl = { fg = 'blue' , bold =true},
  utils.make_flexible_component(9,{
    provider = function(self)
      return " "..self.lfilename.." "
    end,
  },{
    provider = function(self)
      return " "..vim.fn.pathshorten(self.lfilename).." "
    end,
  }),
}
local FileFlags = {
  fallthrough = false,
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = "[+] ",
    hl = { fg = "green" },
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = " ",
    hl = { fg = "orange" },
  },
}
local FileNameModifer = {
  hl = function(self)
    if vim.bo.modified then
      return { fg = "cyan", bold = true, force=true }
    end
  end,
}
-- -- let's add the children to our FileNameBlock component
FileNameBlock = utils.insert(FileNameBlock,
  utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
  unpack(FileFlags), -- A small optimisation, since their parent does nothing
  { provider = '%<'} -- this means that the statusline is cut here when there's not enough space
)
-- FileNameBlock = {FileNameBlock,FileName}
local Right_filebar = {
  provider = function(self)
    return ''
    -- return ')'
  end,
  hl = function(self)
    local val = {}
    val.fg = 'yellow'
    return val
  end,
}
local GitBranch = {
  condition = conditions.is_git_repo,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
  end,
  hl = { fg = "orange" },
  {   -- git branch name
    provider = function(self)
      return " " .. self.status_dict.head
    end,
    hl = { bold = true }
  },
}
local GitDetails = {
  condition = conditions.is_git_repo,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and ("+" .. count)
    end,
    hl = { fg = "git_add" },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and ("-" .. count)
    end,
    hl = { fg = "git_del" },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ("~" .. count)
    end,
    hl = { fg = "git_change" },
  },
}
local Git = {
  utils.make_flexible_component(3,{
    GitBranch, Space, GitDetails
  },{
    GitBranch
  },{
    provider = function(self) return "" end
  }),
}
local TreesitterStatus = {
  provider = myUtils.Functions.TreesitterStatus,
  hl = function(self)
    local val = {}
    val.fg = 'skyblue'
    return val
  end,
}
local LSPStatus = {
  provider = myUtils.Functions.LSPStatus,
  condition = myUtils.Conditions.CheckLSP,
  hl = function(self)
    local val = {}
    val.fg = 'yellow'
    return val
  end,
}
local Diagnostics = {
  condition = conditions.has_diagnostics and myUtils.Conditions.FullBar,
  static = {
    error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
    warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
    info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
    hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
  },
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  update = { "DiagnosticChanged", "BufEnter" },
  {
    provider = function(self)
      -- 0 is just another output, we can decide to print it or not!
      return self.errors > 0 and (self.error_icon .. self.errors .. " ")
    end,
    hl = { fg = "diag_error" },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
    end,
    hl = { fg = "diag_warn" },
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info .. " ")
    end,
    hl = { fg = "diag_info" },
  },
  {
    provider = function(self)
	return self.hints > 0 and (self.hint_icon .. self.hints)
    end,
    hl = { fg = "diag_hint" },
  },
}
-- We can now define some children separately and add them later
local FileTypeIcon = {
  init = function(self)
    self.filetype = string.upper(vim.bo.filetype)
    local filename = vim.api.nvim_buf_get_name(0)
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon and (self.icon .. " " .. self.filetype)
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end
  -- hl = { fg = utils.get_highlight("Type").fg, bold = true },
}
local Position = {
  provider = myUtils.Functions.LinesInfo,
  update = {
    "ModeChanged",
  },
  hl = function(self)
    local val = {}
    val.fg = 'orange'
    return val
  end,
}
local ScrollBar = {
  provider = myUtils.Functions.ScrollBar,
  hl = function(self)
    local val = {}
    val.fg = 'violet'
    val.bg = 'darkblue'
    return val
  end,
}
local FileSize = {
  provider = function()
    -- stackoverflow, compute human readable file size
    local suffix = { 'b', 'k', 'M', 'G', 'T', 'P', 'E' }
    local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
    fsize = (fsize < 0 and 0) or fsize
    if fsize < 1024 then
      return fsize..suffix[1]
    end
    local i = math.floor((math.log(fsize) / math.log(1024)))
    return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i + 1])
  end,
  hl = function(self)
    local val = {}
    local filename = vim.fn.expand('%:t')
    local extension = vim.fn.expand('%:e')
    local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
    if icon ~= nil then
      val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
    else
      val.fg = 'orange'
    end
    return val
  end,
}
local FileEncoding = {
  provider = function()
    local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
    return enc ~= 'utf-8' and enc:upper()
  end
}
local FileFormat = {
  provider = function()
    local fmt = vim.bo.fileformat
    return fmt ~= 'unix' and fmt:upper()
  end
}

--------------------------------------------------
-- Flexible Components
--------------------------------------------------
local make_flexible = function(num,component)
  return utils.make_flexible_component(num,{
    component
  },{
    provider = function(self) return "" end
  })
end
FileEncoding = make_flexible(2,FileEncoding)
FileFormat = make_flexible(3,FileFormat)
ScrollBar = make_flexible(4,ScrollBar)
FileSize = make_flexible(5,FileSize)
GitDetails = make_flexible(6,GitDetails)
GitBranch = make_flexible(7,GitBranch)
FileTypeIcon = make_flexible(8,FileTypeIcon)
Position = make_flexible(9,Position)

OSMode = utils.make_flexible_component(1,{
  OSMode
  },{
    init = function(self)
      self.mode = vim.fn.mode(1)
    end,
    provider = myUtils.Functions.OSicon,
    hl = function(self)
      local mode = self.mode:sub(1, 1)
      return { fg = 'bg', bg = mode_colors[mode], bold = true, }
    end,
  },
  SideBar
)

--------------------------------------------------
-- Inactive Components
--------------------------------------------------
local InactiveMode = {
  provider = function()
    return ''
  end,
  hl = {
    fg = 'blue',
    bg = 'black',
    bold = true
  },
}
local InactiveSep = {
  provider = function()
    return ' -> '
  end,
  hl = {
    fg = 'yellow',
    bg = 'black',
    bold = true
  },
}
local InactiveSep = {
  provider = function()
    return ' -> '
  end,
  hl = {
    fg = 'yellow',
    bg = 'black',
    bold = true
  },
}
local InactiveFiletype = {
  provider = function()
    local filetype = string.upper(vim.bo.filetype)
    return ' FT : '..filetype.." "
  end,
  condition = myUtils.Conditions.BufferNotEmpty,
  hl = { fg = 'skyblue' },
}
local InactiveFilename = {
  condition = myUtils.Conditions.BufferNotEmpty,
  init = function(self)
      self.filename = vim.api.nvim_buf_get_name(0)
  end,
}
local InactiveFilename = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
    self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
    if self.lfilename == "" then self.lfilename = "[No Name]" end
  end,
  hl = { bg = 'blue' , fg = 'black', italic = true, bold = true },
  utils.make_flexible_component(9,{
    provider = function(self)
      return " "..self.lfilename.." "
    end,
  },{
    provider = function(self)
      return " "..vim.fn.pathshorten(self.lfilename).." "
    end,
  }),
}
local Align = { provider = "%=" }
local Space = { provider = " " }

local ActiveStatusLine = {
  ViMode, Space, Left_filebar, FileNameBlock, Right_filebar, Space, Git,
  Align, TreesitterStatus, Space, LSPStatus, Align,
  Diagnostics, Space, Position, Space, FileTypeIcon, Space, ScrollBar, Space, FileFormat, FileEncoding, FileSize, Space, OSMode
}
local InactiveStatusLine = {
  condition = conditions.is_not_active,
  Space, InactiveMode, InactiveSep, Space, Left_filebar, InactiveFilename, Right_filebar
}
local SpecialStatusLine = {
  condition = function()
    return conditions.buffer_matches({
      buftype = { "prompt", "help", "quickfix" },
      filetype = special_filetypes,
    })
  end,
  Space, InactiveMode, InactiveSep, ViMode, Space, Left_filebar, InactiveFiletype, Right_filebar
}

local StatusLine = {
  fallthrough = false,
  SpecialStatusLine, InactiveStatusLine, ActiveStatusLine
}

return StatusLine
