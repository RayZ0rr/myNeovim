local mini_line = require('mini.statusline')
local flexible_fn = require('mini.statusline').flexibleGroups
local mini_utils = mini_line.utils
local my_utils = require('config.plugins.general.statusline.utils')
local fn = my_utils.func

my_utils.initHLcolors()
local color_suffix = my_utils.color_suffix

local hl = {}

local mode = function()
    return " %2(["..my_utils.vim_mode.names[vim.fn.mode()].."%)] "
end
hl.mode = function()
    return color_suffix .. "BoldFg" .. my_utils.vim_mode.colors[vim.fn.mode()]
end

local mode_icon = function() return "  " end
hl.mode_icon = function()
    return color_suffix .. "BlackBg" .. my_utils.vim_mode.colors[vim.fn.mode()]
end

local numOfDiag = function(args)
    local count = mini_utils.diagnostic_counts[vim.api.nvim_get_current_buf()]
    if count == nil or mini_utils.diagnostic_is_disabled() then return '' end
    local icon = my_utils.icons[args.severity] or ""
    local n = count[vim.diagnostic.severity[args.severity]] or 0
    local str = n > 0 and (icon .. n) or ""
    return fn.strPrefixSuffix(str, args)
end

local file_info = {}
file_info.type = function(args)
    local filetype = vim.bo.filetype
    mini_utils.ensure_get_icon() -- Add filetype icon
    if mini_utils.get_icon ~= nil and filetype ~= '' then
        filetype = mini_utils.get_icon(filetype) .. ' ' .. filetype
        filetype = fn.strPrefixSuffix(filetype, args)
    end
    return filetype
end
hl.filename = function()
    if vim.bo.modified then
        return color_suffix .. "FgCyan"
    end
    return color_suffix .. "FgBlue"
end
hl.fileStatus = function()
    if vim.bo.modified then
        return color_suffix .. "FgCyan"
    end
    return color_suffix .. "FgOrange"
end

local space = {string = function() return ' ' end, hl = 'StatusLine'}
local align = {string = function() return '%=' end, hl = 'StatusLine'}
local arrow_left = {string = function() return ' ' end, hl = color_suffix .. 'FgYellow'}
local arrow_right = {string = function() return ' ' end, hl = color_suffix .. 'FgYellow'}
local git = mini_line.section_git

local groups = {
    {priority = 1, string = mode_icon, hl_fn = hl.mode_icon},
    {priority = 9, string = mode, hl_fn = hl.mode},
    arrow_left,
    {priority = 5, string = {fn.fileName, fn.fileNameShort}, hl_fn = hl.filename},
    {priority = 4, string = function() return fn.fileStatus({prefix = ' '}) end,
     hl_fn = hl.filestatus},
    arrow_right,
    {priority = 3, string = function()
        return ' ' .. git({})
    end, hl = color_suffix .. 'FgViolet'},
    {priority = 9, string = function() return fn.gitDiffInfo({prefix = ' '}) end},
    align,
    {string = fn.treesitterInfo, hl = color_suffix .. 'FgSkyblue'},
    space,
    {string = fn.lspInfo, hl = color_suffix .. 'FgYellow'},
    space,
    {priority = 13, string = function() return numOfDiag({severity = "ERROR", prefix= ' '}) end,
     hl = "DiagnosticError"},
    {priority = 12, string = function() return numOfDiag({severity = "WARN", prefix= ' '}) end,
     hl = "DiagnosticWarn"},
    {priority = 11, string = function() return numOfDiag({severity = "INFO", prefix= ' '}) end,
     hl = "DiagnosticInfo"},
    {priority = 10, string = function() return numOfDiag({severity = "HINT", prefix= ' '}) end,
     hl = "DiagnosticHint"},
    align,
    {string = fn.linesInfo, hl = color_suffix .. 'FgOrange'},
    -- {string = function() return ' ' .. mini_line.section_fileinfo({trunc_width = 1000}) end, hl = color_suffix .. 'FgBlue'},
    {string = function() return file_info.type({prefix = ' '}) end, hl = color_suffix .. 'FgBlue'},
    {string = function() return fn.fileSize({prefix = ' '}) end, hl = color_suffix .. 'FgYellow'},
    {string = function() return fn.fileEncoding({prefix = ' '}) end, hl = color_suffix .. 'FgCream'},
    {string = function() return fn.fileFormat({prefix = ' '}) end, hl_fn = hl.mode},
    space,
    {string = fn.osInfo, hl_fn = hl.mode_icon},
}

require('mini.statusline').setup({
    content = {
        -- Content for active window
        active = flexible_fn({groups=groups}),
        -- Content for inactive window(s)
        inactive = nil,
    },
})
