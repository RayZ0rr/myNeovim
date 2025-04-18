local M = {}

function M.map(mode, lhs, rhs, opts)
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

function M.tnmap(lhs, rhs, opts)
    local options = {remap = false, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set('t', lhs, rhs, options)
end

function M.executable(name)
  if vim.fn.executable(name) > 0 then
    return true
  end

  return false
end

M.root_markers = {
  '.gitignore',
  'CMakeLists.txt',
  'compile_commands.json',
  'compile_flags.txt',
  'configure.ac', -- AutoTools
  'cmake',
  'setup.py',
  'requirements.txt',
  'build',
  '.clangd',
  '.clang-tidy',
  '.clang-format',
}

M.root_dir = function(fname, rm)
    fname = fname or 0
    -- fname = fname or vim.api.nvim_buf_get_name(0)
    rm = rm or M.root_markers
    return vim.fs.root(fname, rm)
end

function M.hlSet(name, data)
    data = data or {}
    vim.api.nvim_set_hl(0, name, data)
end

function M.hlSetDefault(name, data)
    data = data or {}
    data.default = true
    vim.api.nvim_set_hl(0, name, data)
end

return M
