local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local my_utils = require('plugins.general.statusline.utils')

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

-- Helpers
--------------------------------------------------
local Align = { provider = "%=" }
local Space = { provider = " " }
local function vimode_hl()
    return my_utils.vim_mode.colors[vim.fn.mode()]
end

-- Left Part
--------------------------------------------------
local SideBar = {
    provider = function()
	return '▊'
    end,
    hl = function()
	-- auto change color according to neovims mode
	return { fg = vimode_hl() }
    end,
}

local vim_mode_icon = {
    provider = function(self)
	return "  "
	-- local mode = "["..string.upper(vim.fn.mode(1)).."]"
	-- return " "..mode
    end,
    hl = function(self)
	local mode = self.mode:sub(1, 1) -- get only the first mode character
	return { fg = 'bg', bg = my_utils.vim_mode.colors[mode], bold = true, }
    end,
}

local vim_mode_mode = {
    provider = function(self)
	return " %2(["..my_utils.vim_mode.names[self.mode].."%)]"
    end,
    hl = function(self)
	local mode = self.mode:sub(1, 1)
	return { fg = my_utils.vim_mode.colors[mode], bold = true, }
    end,
}

local vim_mode = {
    init = function(self)
	self.mode = vim.fn.mode(1)
    end,
    flexible = 11,
    {
	vim_mode_icon, vim_mode_mode
    },
    {
	vim_mode_icon
    }
}

local left_filebar = {
    provider = function(self)
	return ''
    end,
    hl = function(self)
	local val = {}
	val.fg = 'yellow'
	return val
    end,
}

local file_name_block = {
    condition = my_utils.Conditions.BufferNotEmpty,
    -- let's first set up some attributes needed by this component and it's children
    init = function(self)
	self.filename = vim.api.nvim_buf_get_name(0)
    end,
}
-- We can now define some children separately and add them later
local file_name = {
    provider = function(self)
	-- first, trim the pattern relative to the current directory. For other
	-- options, see :h filename-modifers
	local filename = vim.fn.fnamemodify(self.filename, ":.")
	if filename == "" then return "[No Name]" end
	-- now, if the filename would occupy more than 1/4th of the available
	-- space, we trim the file path to its initials
	-- See Flexible Components section below for dynamic truncation
	if not conditions.width_percent_below(#filename, 0.25) then
	    filename = vim.fn.pathshorten(filename)
	end
	return filename
    end,
    hl = function()
        if vim.bo.modified then
            -- use `force` because we need to override the child's hl foreground
            return { fg = "cyan", bold = true, force=true }
        end
	return { fg = 'blue' , bold =true}
	-- return { fg = utils.get_highlight("Directory").fg }
    end,
}
local file_flags = {
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
-- -- let's add the children to our FileNameBlock component
file_name_block = utils.insert(file_name_block,
    Space,
    file_name,
    Space,
    file_flags
)

local right_filebar = {
    provider = function(self)
	return ''
    end,
    hl = function(self)
	local val = {}
	val.fg = 'yellow'
	return val
    end,
}

local os_mode = {
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
	    return { fg = my_utils.vim_mode.colors[mode], bold = true, }
	end,
    },
    {
	provider = my_utils.Functions.OSicon,
	hl = function(self)
	    local mode = self.mode:sub(1, 1)
	    return { fg = 'bg', bg = my_utils.vim_mode.colors[mode], bold = true, }
	end,
    },
}
os_bar = {
    flexible=1,
    os_mode,
    {
	init = function(self)
	    self.mode = vim.fn.mode(1)
	end,
	provider = my_utils.Functions.OSicon,
	hl = function(self)
	    local mode = self.mode:sub(1, 1)
	    return { fg = 'bg', bg = vimode_hl(), bold = true, }
	end,
    },
    SideBar
}

local git_branch = {
    provider = function(self)
	return " " .. self.status_dict.head
    end,
    hl = { fg = "violet", bold = true },
}
local git_status = {
    {
	provider = function(self)
	    local count = self.status_dict.added or 0
	    return count > 0 and ("+" .. count)
	end,
	hl = { fg = "green" },
    },
    {
	provider = function(self)
	    local count = self.status_dict.removed or 0
	    return count > 0 and ("-" .. count)
	end,
	hl = { fg = "red" },
    },
    {
	provider = function(self)
	    local count = self.status_dict.changed or 0
	    return count > 0 and ("~" .. count)
	end,
	hl = { fg = "orange" },
    },
}
local git_info = {
    condition = conditions.is_git_repo,
    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,
    flexible=9,
    {
	git_branch, Space, git_status
    },
    {
	git_branch
    },
    {
	provider = function(self) return "" end
    }
}

-- Centre Part
--------------------------------------------------
local TreesitterStatus = {
    provider = my_utils.Functions.TreesitterStatus,
    hl = function(self)
	local val = {}
	val.fg = 'skyblue'
	return val
    end,
}

local LSP_status = {
    condition = conditions.lsp_attached,
    -- condition = my_utils.Conditions.CheckLSP,
    update = {'LspAttach', 'LspDetach'},
    provider = my_utils.Functions.LSPStatus,
    hl = function(self)
	local val = {}
	val.fg = 'yellow'
	return val
    end,
}

local Diagnostics = {
    condition = conditions.has_diagnostics,
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
	hl = { fg = "diag_err" },
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

-- Right Part
--------------------------------------------------
local line_info = {
    provider = my_utils.Functions.LinesInfo,
    -- provider = "%7(%l:%2c%3L%)",
    hl = function(self)
	local val = {}
	val.fg = 'orange'
	return val
    end,
}

local scrollbar = {
    provider = my_utils.Functions.ScrollBar,
    hl = function(self)
	local val = {}
	val.fg = 'magenta'
	val.bg = 'darkblue'
	return val
    end,
}

local file_type_icon = {
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
    hl = { fg = "yellow" },
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
    return {
	flexible =num,
	component,
	{
	    provider = function(self) return "" end
	}
    }
end

FileEncoding = make_flexible(2, FileEncoding)
FileFormat = make_flexible(3, FileFormat)
scrollbar = make_flexible(4, scrollbar)
FileSize = make_flexible(5, FileSize)
file_type_icon = make_flexible(6, file_type_icon)
line_info = make_flexible(7, line_info)

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
    condition = my_utils.Conditions.BufferNotEmpty,
    hl = { fg = 'skyblue' },
}
local InactiveFilename = {
    condition = my_utils.Conditions.BufferNotEmpty,
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
    {flexible=9,{
	provider = function(self)
	    return " "..self.lfilename.." "
	end,
    },{
	    provider = function(self)
		return " "..vim.fn.pathshorten(self.lfilename).." "
	    end,
	}},
}

local ActiveStatusLine = {
    vim_mode, Space, left_filebar, file_name_block, right_filebar, Space, git_info,
    Align, TreesitterStatus, Space, LSP_status, Space, Diagnostics, Align,
    line_info, Space, file_type_icon, Space, scrollbar, Space, FileFormat, FileEncoding, FileSize, Space, os_bar
}
local InactiveStatusLine = {
    condition = conditions.is_not_active,
    Space, InactiveMode, InactiveSep, Space, left_filebar, InactiveFilename, right_filebar
}
local SpecialStatusLine = {
    condition = function()
	return conditions.buffer_matches({
	    buftype = { "prompt", "help", "quickfix" },
	    filetype = special_filetypes,
})
    end,
    Space, InactiveMode, InactiveSep, vim_mode, Space, left_filebar, InactiveFiletype, right_filebar
}

local StatusLine = {
    fallthrough = false,
    SpecialStatusLine, InactiveStatusLine, ActiveStatusLine
}

return StatusLine
