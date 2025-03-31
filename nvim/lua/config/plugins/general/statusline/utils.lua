local M = {}

M.color_suffix = "MyColors"

M.icons = {
  linux = '  ',
  macos = '  ',
  windows = '   ',

  ERROR = ' ',
  WARN = ' ',
  INFO = ' ',
  HINT = ' ',

  lsp = ' ',
  git = ''
}

M.func = {
    strPrefixSuffix = function(str, args)
        args = args or {}
        local suffix = args.suffix or ''
        local prefix = args.prefix or ''
        return prefix .. str .. suffix
    end,
    osInfo = function(args)
        local fmt = vim.bo.fileformat
        local icon
        if fmt == 'unix' then
            icon = M.icons.linux
        elseif fmt == 'mac' then
            icon = M.icons.macos
        else
            icon = M.icons.windows
        end
        return M.func.strPrefixSuffix(icon, args)
    end,
    linesInfo = function(args)
        -- local line = vim.fn.line('.')
        -- local column = vim.fn.col('.')
        -- local total_line = vim.fn.line('$')
        -- local str = string.format("%d:%d  %d", column, line, total_line)
        local str = '%l:%L  %v'
        return M.func.strPrefixSuffix(str, args)
    end,
    treesitterInfo = function(args)
        local ts = vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()]
        local str = (ts and next(ts)) and " 綠TS" or ""
        if str:len() == 0 then return "" end
        return M.func.strPrefixSuffix(str, args)
    end,
    lspInfo = function(args)
        local clients = vim.lsp.get_active_clients({ bufnr = 0 }) or {}
        local name = clients[1] and clients[1].name or ''
        for i = 2, vim.tbl_count(clients) do
            name = name .. clients[i].name
        end
        if name:len() == 0 then return "" end
        local str = " [" .. name .. "]"
        -- local str = " [" .. name .. "]"
        return M.func.strPrefixSuffix(str, args)
    end,
    truncate = function(trunc_width, trunc_len, hide_width, no_ellipsis)
        return function(str)
            local win_width = vim.fn.winwidth(0)
            if hide_width and win_width < hide_width then return ''
            elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
                return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
            end
            return str
        end
    end,
    scrollBar = function(args)
        local bars = {
            type1 = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' },
            -- Another variant, because the more choice the better.
            type2 = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
        }
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local i = math.floor((curr_line - 1) / lines * #bars.type1) + 1
        local str = string.rep(bars.type1[i], 2)
        return M.func.strPrefixSuffix(str, args)
    end,
    fileName = function(args)
        local f = vim.api.nvim_buf_get_name(0)
        f = vim.fn.fnamemodify(f, ":.")
        if f == "" then return "[No Name]" end
        return M.func.strPrefixSuffix(f, args)
    end,
    fileNameShort = function(args)
        local f = vim.api.nvim_buf_get_name(0)
        f = vim.fn.fnamemodify(f, ":.")
        f = vim.fn.pathshorten(f)
        if f == "" then return "[No Name]" end
        return M.func.strPrefixSuffix(f, args)
    end,
    fileStatus = function()
        if vim.bo.modified then
            return "[+] "
        elseif not vim.bo.modifiable or vim.bo.readonly then
            return " "
        else
            return ""
        end
    end,
    fileEncoding = function(args)
        local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.bo.enc -- :h 'enc'
        return enc ~= 'utf-8' and M.func.strPrefixSuffix(enc, args) or ''
    end,
    fileFormat = function(args)
        local fmt = vim.bo.fileformat
        return fmt ~= 'unix' and M.func.strPrefixSuffix(fmt, args) or ''
    end,
    gitDiffInfo = function(args)
        local s = vim.b.gitsigns_status_dict
        if s == nil then return '' end
        local a, r, c = s.added, s.removed, s.changed
        a = (a and a > 0) and ("%#Added#+" .. a .. " ") or ''
        r = (r and r > 0) and ("%#Removed#-" .. r .. " ") or ''
        c = (c and c > 0) and ("%#Changed#c" .. c) or ''
        local str = a .. r .. c
        return M.func.strPrefixSuffix(str, args)
    end,
    gitDiffAdd = function(args)
        local s = vim.b.gitsigns_status_dict
        if s == nil then return '' end
        local a = s.added
        a = (a and a > 0) and ("%#DiffAdd#+" .. a) or ''
        return M.func.strPrefixSuffix(a, args)
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

M.colors = {
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
    grey       = '#bbc2cf',
    black       = '#202328',
    white       = '#ffffff',
}

local hlSetDefault = function(name, data)
    data.default = true
    vim.api.nvim_set_hl(0, name, data)
end
function M.initHLcolors()
    suffix = M.color_suffix
    for name, color in pairs(M.colors) do -- Create highlight groups for all colors in M.colors
        hlSetDefault(suffix .. 'Fg' .. name, { fg = color }) -- Foreground group
        hlSetDefault(suffix .. 'BlackFg' .. name, { fg = color, bg = 'black' }) -- Foreground group
        hlSetDefault(suffix .. 'WhiteFg' .. name, { fg = color, bg = 'white' }) -- Foreground group
        hlSetDefault(suffix .. 'BoldFg' .. name, { fg = color, bold=true }) -- Foreground group
        hlSetDefault(suffix .. 'ItalicFg' .. name, { fg = color, italic=true }) -- Foreground group
        hlSetDefault(suffix .. 'Bg' .. name, { bg = color }) -- Background group
        hlSetDefault(suffix .. 'BlackBg' .. name, { fg = 'black', bg = color }) -- Blackground group
        hlSetDefault(suffix .. 'WhiteBg' .. name, { fg = 'white', bg = color }) -- Blackground group
    end
end

M.vim_mode = {
  colors = {
    n = 'Green',
    i = 'Red',
    v = 'Magenta',
    [''] = 'Blue',
    V = 'Blue',
    c = 'Magenta',
    no = 'Green',
    s = 'Orange',
    S = 'Orange',
    [''] = 'Orange',
    ic = 'Yellow',
    R = 'Violet',
    Rv = 'Violet',
    cv = 'Red',
    ce = 'Red',
    r = 'Cyan',
    rm = 'Cyan',
    ['r?'] = 'Cyan',
    ['!'] = 'Red',
    t = 'Red',
  },
  names = { -- change the strings if you like it vvvvverbose!
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
