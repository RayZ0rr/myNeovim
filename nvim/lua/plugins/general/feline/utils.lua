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

local M = {}

M.OSinfo = function()
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

M.LinesInfo = function()
  local line = vim.fn.line('.')
  local column = vim.fn.col('.')
  local total_line = vim.fn.line('$')
  return string.format("%d:%d  %d", column, line, total_line)
end

M.TreesitterStatus = function()
  local ts = vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()]
  return (ts and next(ts)) and " 綠TS" or ""
end

M.BufferNotEmpty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

M.FullBar = function()
  return vim.api.nvim_win_get_width(0) > 95
end

M.BarWidth = function(n)
  return (vim.opt.laststatus:get() == 3 and vim.opt.columns:get() or vim.fn.winwidth(0)) > (n or 80)
end

M.BufferEmpty = function()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand '%:t') ~= 1
end

M.CheckWidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

return M
