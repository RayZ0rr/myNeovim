
local map = require('config/options/utils').map
local nnmap = require('config/options/utils').nnmap
local inmap = require('config/options/utils').inmap
local xnmap = require('config/options/utils').xnmap

nnmap('<leader>ff', function() require("fzf-lua").files({show_cwd_header=true}) end, {desc="Fzf-Lua files search"})
nnmap('<leader>fa', ":FzfLua files cwd=~<CR>", {desc="Fzf-Lua files search home"})
nnmap('<leader>fn', "<cmd>lua require('fzf-lua').files({cwd = '~/.config/nvim'})<CR>", {desc="Fzf-Lua files search nvim"})
nnmap(
  '<leader>fo',
  function()
    require('fzf-lua').oldfiles({
    cwd_only = function()
      return vim.api.nvim_command('pwd') ~= vim.env.HOME
    end
    })
  end
)

local util = require 'lspconfig.util'
local root_files = {
  '.clangd',
  '.clang-tidy',
  '.clang-format',
  'compile_commands.json',
  'compile_flags.txt',
  'configure.ac', -- AutoTools
  'cmake',
  'setup.py',
  'requirements.txt',
  'build'
}
root_dir = function(fname)
  return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
end,
nnmap('<leader>fp', function() require('fzf-lua').files({cwd = root_dir(vim.api.nvim_buf_get_name(0))}) end, {desc="Fzf-Lua search project"})

map({'n', 'x',}, '<leader>fr',function() require('fzf-lua').registers() end,{desc="Fzf-Lua registers"})

-- nnmap('<leader>gg',  "<cmd>FzfLua grep_project<CR>")
nnmap('<leader>gg', function() require("fzf-lua").grep({ search = "", fzf_opts = { ['--nth'] = '2..' } }) end, {desc="Fzf-Lua grep"})
nnmap('<leader>gr', function() require("fzf-lua").grep({ continue_last_search = true }) end, {desc="Fzf-Lua grep continue last"})
nnmap('<leader>gl', function() require("fzf-lua").live_grep({ exec_empty_query = true}) end, {desc="Fzf-Lua live grep"})
xnmap('<leader>gv',  "<cmd>FzfLua grep_visual<CR>", {desc="Fzf-Lua grep visual"})
nnmap('<leader>gp', function() require'fzf-lua'.grep_project({ fzf_opts={ ['--query']=vim.fn.expand('<cword>') }}) end, {desc="Fzf-Lua project grep"})

nnmap('<leader>fgi', function() require("fzf-lua").git_files() end, {desc="Fzf-Lua git files"})
nnmap('<leader>fbb', function() require("fzf-lua").buffers() end , {desc="Fzf-Lua buffers"})
nnmap('<leader>fbl', function() require("fzf-lua").blines() end, {desc="Fzf-Lua buffer lines"})
nnmap('<leader>fl',  function() require("fzf-lua").lines() end, {desc="Fzf-Lua lines"})
nnmap('<leader>fh',  function() require("fzf-lua").help_tags() end, {desc="Fzf-Lua help tags"})
nnmap('<leader>fk', function() require("fzf-lua").man_pages() end, {desc="Fzf-Lua man pages"})
nnmap('<leader>fm', function() require("fzf-lua").marks() end, {desc="Fzf-Lua marks"})
nnmap('<leader>fc', "<cmd>lua require('fzf-lua').command_history()<CR>", {desc="Fzf-Lua command history"})
