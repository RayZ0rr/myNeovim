local M = {}

function M.map(mode, lhs, rhs, opts)
    -- local options = { remap = false }
    -- if opts then
    --     options = vim.tbl_extend("force", options, opts)
    -- end
    vim.keymap.set(mode, lhs, rhs, opts)
end

function M.bmap(mode, lhs, rhs, opts)
    local options = {buffer = true, remap = false, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

function M.nnmap(lhs, rhs, opts)
    local options = {remap = false, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set('n', lhs, rhs, options)
end

function M.inmap(lhs, rhs, opts)
    local options = {remap = false, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set('i', lhs, rhs, options)
end

function M.vnmap(lhs, rhs, opts)
    local options = {remap = false, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set('v', lhs, rhs, options)
end

function M.xnmap(lhs, rhs, opts)
    local options = {remap = false, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set('x', lhs, rhs, options)
end

return M
