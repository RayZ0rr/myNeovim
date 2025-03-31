local mini_line = require('mini.statusline')
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
    return str
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
file_info.size = function(args)
    local size = mini_utils.get_filesize()
    return fn.strPrefixSuffix(size, args)
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
    {priority = 10, string = function() return ' '.. numOfDiag({severity = "ERROR"}) end,
     hl = "DiagnosticError"},
    {priority = 9, string = function() return numOfDiag({severity = "WARN"}) end,
     hl = "DiagnosticWarn"},
    {priority = 8, string = function() return numOfDiag({severity = "INFO"}) end,
     hl = "DiagnosticInfo"},
    {priority = 7, string = function() return numOfDiag({severity = "HINT"}) end,
     hl = "DiagnosticHint"},
    align,
    {string = fn.linesInfo, hl = color_suffix .. 'FgOrange'},
    {string = function() return file_info.type({prefix = ' '}) end, hl = color_suffix .. 'FgBlue'},
    {string = function() return file_info.size({prefix = ' '}) end, hl = color_suffix .. 'FgYellow'},
    {string = function() return fn.fileEncoding({prefix = ' '}) end, hl = color_suffix .. 'FgCream'},
    {string = function() return fn.fileFormat({prefix = ' '}) end, hl_fn = hl.mode},
    space,
    {string = fn.osInfo, hl_fn = hl.mode_icon},
}

local preProcessGroups = function(groups)
    local processed = {}
    for i, g in ipairs(groups) do -- Add index_
        if type(g) == 'string' then -- Convert strings to tables
            processed[i] = { index_ = i, string = g }
        else
            g = vim.deepcopy(g)
            g.index_ = i
            if g.string and type(g.string) ~= 'table' then
                g.string = {g.string}
            end
            processed[i] = g
        end
    end

    table.sort(processed, function(a, b)
        local pri_a = a.priority or 0
        local pri_b = b.priority or 0
        if pri_a ~= pri_b then
            return (pri_a > pri_b)  -- Correct comparison for descending order
        end
        return a.index_ < b.index_
    end)

    local ordered_result = {}
    for i = 1, #groups do
        ordered_result[i] = ''
    end

    return processed, ordered_result
end

local processGroups = function(groups)
    -- Static preprocessing (called once)
    local processed_groups, ordered_result = preProcessGroups(groups)

    return function()
        local win_width = vim.api.nvim_win_get_width(0)
        local s_width = 0
        local full_result = false

        for idx, group in ipairs(processed_groups) do -- Process all groups in priority order
            if full_result then
                ordered_result[group.index_] = ''
            else
                local content = group.hl or (group.hl_fn and group.hl_fn() or '')
                if content:len() ~= 0 then
                    content = '%#' .. content .. '#'
                end
                local strings = group.string
                if not strings then
                    ordered_result[group.index_] = content
                else
                    local str, width = '', 0
                    for _, strFn in ipairs(strings) do
                        str = strFn()
                        width = vim.api.nvim_eval_statusline(str, {winid = 0, maxwidth = 0}).width
                        if (s_width + width) <= win_width then
                            s_width = s_width + width
                            full_result = false
                            break
                        else
                            str = ''
                            full_result = true
                        end
                    end
                    content = content .. str
                    ordered_result[group.index_] = content
                end
            end
        end
        return table.concat(ordered_result)
    end
end

require('mini.statusline').setup({
    content = {
        -- Content for active window
        active = processGroups(groups),
        -- Content for inactive window(s)
        inactive = nil,
    },
})
