local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local FileIcon = {
  init = function(self)
    local filename = vim.api.nvim_buf_get_name(0)
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    if self.is_active then
      return self.icon and (self.icon .. " ")
    else
      return ""
    end
  end,
  hl = function(self)
    if self.is_active then
      return { fg = self.icon_color }
    else
      return { fg = "gray" }
    end
  end
}
local TablineBufnr = {
  provider = function(self)
    return "▎"..tostring(self.bufnr) .. ". "
  end,
  hl = "Comment",
}

-- we redefine the filename component, as we probably only want the tail and not the relative path
local TablineFileName = {
  provider = function(self)
    -- self.filename will be defined later, just keep looking at the example!
    local filename = self.filename
    filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
    return filename
  end,
  hl = function(self)
    return { bold = self.is_active or self.is_visible, italic = true }
  end,
}
-- this looks exactly like the FileFlags component that we saw in
-- #crash-course-part-ii-filename-and-friends, but we are indexing the bufnr explicitly
-- also, we are adding a nice icon for terminal buffers.
local TablineFileFlags = {
  {
    condition = function(self)
      return vim.api.nvim_buf_get_option(self.bufnr, "modified")
    end,
    provider = "[+]",
    hl = { fg = "green" },
  },
  {
    condition = function(self)
      return not vim.api.nvim_buf_get_option(self.bufnr, "modifiable")
	or vim.api.nvim_buf_get_option(self.bufnr, "readonly")
    end,
    provider = function(self)
      if vim.api.nvim_buf_get_option(self.bufnr, "buftype") == "terminal" then
	return "  "
      else
	return ""
      end
    end,
    hl = { fg = "orange" },
  },
}

-- Here the filename block finally comes together
local TablineFileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(self.bufnr)
  end,
  hl = function(self)
    if self.is_active then
      -- return "TabLineSel"
      return "TabLine"
    -- why not?
    -- elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
    --     return { fg = "gray" }
    else
      -- return "TabLine"
      return { fg = "gray" }
    end
  end,
  on_click = {
    callback = function(_, minwid, _, button)
	if (button == "m") then -- close on mouse middle click
	    vim.api.nvim_buf_delete(minwid, {force = false})
	else
	    vim.api.nvim_win_set_buf(0, minwid)
	end
    end,
    minwid = function(self)
	return self.bufnr
    end,
    name = "heirline_tabline_buffer_callback",
  },
  TablineBufnr,
  FileIcon, -- turns out the version defined in #crash-course-part-ii-filename-and-friends can be reutilized as is here!
  TablineFileName,
  TablineFileFlags,
}

-- a nice "x" button to close the buffer
local TablineCloseButton = {
    condition = function(self)
        return not vim.api.nvim_buf_get_option(self.bufnr, "modified")
    end,
    hl = 'TabLine',
    { provider = " " },
    {
      provider = " ",
      on_click = {
	callback = function(_, minwid)
	  vim.api.nvim_buf_delete(minwid, { force = false })
	end,
	minwid = function(self)
	  return self.bufnr
	end,
	name = "heirline_tabline_close_buffer_callback",
      },
    },
}

-- The final touch!
-- local TablineBufferBlock = utils.surround({ "  ", "" }, function(self)
-- local TablineBufferBlock = utils.surround({ "▎", "▎" }, function(self)
--     if self.is_active then
--         return utils.get_highlight("TabLineSel").bg
--     else
--         return utils.get_highlight("TabLine").bg
--     end
-- end, { TablineFileNameBlock, TablineCloseButton })
local TablineBufferBlock = {TablineFileNameBlock, TablineCloseButton }

-- and here we go
local BufferLine = utils.make_buflist(
    TablineBufferBlock,
    { provider = "", hl = { fg = "gray" } }, -- left truncation, optional (defaults to "<")
    { provider = "", hl = { fg = "gray" } } -- right trunctation, also optional (defaults to ...... yep, ">")
    -- by the way, open a lot of buffers and try clicking them ;)
)

local Tabpage = {
    provider = function(self)
        return "%" .. self.tabnr .. "T " .. self.tabnr .. " %T"
    end,
    hl = function(self)
        if not self.is_active then
            return "TabLine"
        else
            return "TabLineSel"
        end
    end,
}

local TabpageClose = {
    provider = "%999X  %X",
    hl = "TabLine",
}

local TabPages = {
    -- only show this component if there's 2 or more tabpages
    condition = function()
        return #vim.api.nvim_list_tabpages() >= 2
    end,
    { provider = "%=" },
    utils.make_tablist(Tabpage),
    TabpageClose,
}

local TabLineOffset = {
    condition = function(self)
        local win = vim.api.nvim_tabpage_list_wins(0)[1]
        local bufnr = vim.api.nvim_win_get_buf(win)
        self.winid = win

        if vim.bo[bufnr].filetype == "netrw" then
            self.title = "netrw"
            return true
        -- elseif vim.bo[bufnr].filetype == "TagBar" then
        --     ...
        end
    end,

    provider = function(self)
        local title = self.title
        local width = vim.api.nvim_win_get_width(self.winid)
        local pad = math.ceil((width - #title) / 2)
        return string.rep(" ", pad) .. title .. string.rep(" ", pad)
    end,

    hl = function(self)
        if vim.api.nvim_get_current_win() == self.winid then
            return "TablineSel"
        else
            return "Tabline"
        end
    end,
}

local TabLine = { TabLineOffset, BufferLine, TabPages }

-- Yep, with heirline we're driving manual!
-- vim.o.showtabline = 2
vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])

return TabLine
