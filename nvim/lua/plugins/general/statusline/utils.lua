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

M.Functions = {
  OSinfo = function()
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
  end,
  OSicon = function()
    local os = vim.bo.fileformat:upper()
    local icon
    if os == 'UNIX' then
      icon = icons.linux
    elseif os == 'MAC' then
      icon = icons.macos
    else
      icon = icons.windows
    end
    return icon
  end,
  LinesInfo = function()
    local line = vim.fn.line('.')
    local column = vim.fn.col('.')
    local total_line = vim.fn.line('$')
    return string.format("%d:%d  %d", column, line, total_line)
  end,
  TreesitterStatus = function()
    local ts = vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()]
    return (ts and next(ts)) and " 綠TS" or ""
  end,
  LSPStatus = function()
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
	return "c "..client.name
      end
    end
    return ""
  end,
  Truncate = function(trunc_width, trunc_len, hide_width, no_ellipsis)
    return function(str)
      local win_width = vim.fn.winwidth(0)
      if hide_width and win_width < hide_width then return ''
      elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
	 return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
      end
      return str
    end
  end,
  ScrollBar = function()
    local bars = {
	type1 = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' },
	-- Another variant, because the more choice the better.
	type2 = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
    }
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = math.floor((curr_line - 1) / lines * #bars.type1) + 1
    return string.rep(bars.type1[i], 2)
  end,
}

M.Conditions = {
  BufferNotEmpty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  HideWidth = function()
    return vim.fn.winwidth(0) > 80
  end,
  CheckGit = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
  CheckLSP = function()
    local clients = vim.lsp.get_active_clients()
    return next(clients) ~= nil
  end,
  FullBar = function()
    return vim.fn.winwidth(0) > 85
  end,
  BarWidth = function(n)
    return (vim.opt.laststatus:get() == 3 and vim.opt.columns:get() or vim.fn.winwidth(0)) > (n or 80)
  end,
  BufferEmpty = function()
      -- Check whether the current buffer is empty
      return vim.fn.empty(vim.fn.expand '%:t') == 1
  end,
  CheckWidth = function()
    local squeeze_width  = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
      return true
    end
    return false
  end,
}

M.Vars = {
  colors = {
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
  },
  mode_names = { -- change the strings if you like it vvvvverbose!
    n = "N",
    no = "N?",
    nov = "N?",
    noV = "N?",
    ["no\22"] = "N?",
    niI = "Ni",
    niR = "Nr",
    niV = "Nv",
    nt = "Nt",
    v = "V",
    vs = "Vs",
    V = "V_",
    Vs = "Vs",
    ["\22"] = "^V",
    ["\22s"] = "^V",
    s = "S",
    S = "S_",
    ["\19"] = "^S",
    i = "I",
    ic = "Ic",
    ix = "Ix",
    R = "R",
    Rc = "Rc",
    Rx = "Rx",
    Rv = "Rv",
    Rvc = "Rv",
    Rvx = "Rv",
    c = "C",
    cv = "Ex",
    r = "...",
    rm = "M",
    ["r?"] = "?",
    ["!"] = "!",
    t = "T",
  },
}

return M
