
local map = require('config/options/utils').map
local nnmap = require('config/options/utils').nnmap
local inmap = require('config/options/utils').inmap
local xnmap = require('config/options/utils').xnmap

local fzf_lua = require 'fzf-lua'
local actions = fzf_lua.actions

nnmap('<leader>ff', function() fzf_lua.files({show_cwd_header=true}) end, {desc="Fzf-Lua files search"})
nnmap('<leader>fa', ":FzfLua files cwd=~<CR>", {desc="Fzf-Lua files search home"})
nnmap('<leader>fn', "<cmd>lua require('fzf-lua').files({cwd = '~/.config/nvim'})<CR>", {desc="Fzf-Lua files search nvim"})
nnmap('<leader>fo', function() fzf_lua.oldfiles({show_cwd_header=true}) end, {desc="Fzf-Lua old files search"})
nnmap(
  '<leader>fO',
  function()
    fzf_lua.oldfiles({
    cwd_only = function()
      return vim.api.nvim_command('pwd') ~= vim.env.HOME
    end
    })
  end,
  {desc="Fzf-Lua old files search current dir"}
)

local util = require 'lspconfig.util'
local root_files = {
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
local root_finder = util.root_pattern(unpack(root_files))
local root_dir = function(fname)
    return root_finder(fname) or util.find_git_ancestor(fname)
end
local fzf_project = function()
    fzf_lua.files({cwd = root_dir(vim.api.nvim_buf_get_name(0))})
end
nnmap('<leader>fp', fzf_project, {desc="Fzf-Lua search project"})

map({'n', 'x',}, '<leader>fr',function() fzf_lua.registers() end,{desc="Fzf-Lua registers"})

-- nnmap('<leader>gg',  "<cmd>FzfLua grep_project<CR>")
nnmap('<leader>gg', function() fzf_lua.grep({ search = "", fzf_opts = { ['--nth'] = '2..' } }) end, {desc="Fzf-Lua grep"})
nnmap('<leader>gr', function() fzf_lua.grep({ continue_last_search = true }) end, {desc="Fzf-Lua grep continue last"})
nnmap('<leader>gl', function() fzf_lua.live_grep({ exec_empty_query = true}) end, {desc="Fzf-Lua live grep"})
xnmap('<leader>gv',  "<cmd>FzfLua grep_visual<CR>", {desc="Fzf-Lua grep visual"})
nnmap('<leader>gp', function() fzf_lua.grep_project({ fzf_opts={ ['--query']=vim.fn.expand('<cword>') }, cwd=root_dir(vim.api.nvim_buf_get_name(0))}) end, {desc="Fzf-Lua grep project"})
nnmap('<leader>gP', function() fzf_lua.grep_project({ fzf_opts={ ['--query']=vim.fn.expand('<cword>') } }) end, {desc="Fzf-Lua grep project default"})

nnmap('<leader>fgi', function() fzf_lua.git_files() end, {desc="Fzf-Lua git files"})
nnmap('<leader>fbb', function() fzf_lua.buffers() end , {desc="Fzf-Lua buffers"})
nnmap('<leader>fbl', function() fzf_lua.blines() end, {desc="Fzf-Lua buffer lines"})
nnmap('<leader>fll', function() fzf_lua.lines() end, {desc="Fzf-Lua lines"})
nnmap('<leader>fls', function() fzf_lua.diagnostics_workspace() end, {desc="Fzf-Lua Workspace Diagnostics"})
nnmap('<leader>fh', function() fzf_lua.help_tags() end, {desc="Fzf-Lua help tags"})
nnmap('<leader>fH', function() fzf_lua.man_pages() end, {desc="Fzf-Lua man pages"})
nnmap('<leader>fm', function() fzf_lua.marks() end, {desc="Fzf-Lua marks"})
nnmap('<leader>fc', function() fzf_lua.command_history() end, {desc="Fzf-Lua command history"})
