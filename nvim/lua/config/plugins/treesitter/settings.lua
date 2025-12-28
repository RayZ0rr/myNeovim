-- Treesitter configuration
vim.opt.foldlevel=99

local ensure_installed = {
    "c",
    "cpp",
    "python",
    "bash",
    "lua",
    "rust",
    "go",
    "toml",
    "vim",
    "markdown",
    "query",
}
require'nvim-treesitter'.install(ensure_installed):wait(300000)

vim.api.nvim_create_autocmd('FileType', {
    pattern = ensure_installed,
    callback = function()
        -- syntax highlighting, provided by Neovim
        vim.treesitter.start()
        -- folds, provided by Neovim
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'
        -- indentation, provided by nvim-treesitter
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

require("nvim-treesitter-textobjects").setup {
  select = {
    -- Automatically jump forward to textobj, similar to targets.vim
    lookahead = true,
    selection_modes = {
      ['@parameter.outer'] = 'v', -- charwise
      ['@function.outer'] = 'V', -- linewise
      ['@class.outer'] = '<c-v>', -- blockwise
    },
    include_surrounding_whitespace = false,
  },
}

-- keymaps
vim.keymap.set({ "x", "o" }, "af", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "as", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
end)
vim.keymap.set("n", "<leader>tsa", function()
  require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
end)
vim.keymap.set("n", "<leader>tsA", function()
  require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.outer"
end)


local ok_ts_context, _ = pcall(require, 'ts_context_commentstring')
if ok_ts_context then
    vim.g.skip_ts_context_commentstring_module = true
    require('ts_context_commentstring').setup {}
end
