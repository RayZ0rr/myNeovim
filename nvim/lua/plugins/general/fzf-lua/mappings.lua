
local nnmap = require('options/utils').nnmap
local xnmap = require('options/utils').xnmap

nnmap('<leader>ff',"<cmd>lua require('fzf-lua').files({show_cwd_header=true})<CR>")
nnmap('<leader>fa',":FzfLua files cwd=~<CR>")
nnmap('<leader>fn',":FzfLua files cwd=~/.config/nvim<CR>")
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

-- nnmap('<leader>gg',  "<cmd>FzfLua grep_project<CR>")
nnmap('<leader>gg',  function() require("fzf-lua").grep({ search = "", fzf_opts = { ['--nth'] = '2..' } }) end)
nnmap('<leader>gr',  function() require("fzf-lua").grep({ continue_last_search = true }) end)
nnmap('<leader>gl',  function() require("fzf-lua").live_grep({ exec_empty_query = true, debug=true }) end)
xnmap('<leader>gv',   "<cmd>FzfLua grep_visual<CR>")
nnmap('<leader>gw',  function() require'fzf-lua'.grep_project({ fzf_opts={ ['--query']=vim.fn.expand('<cword>') }}) end)

nnmap('<leader>fgi',  "<cmd>Fzflua git_files<CR>")
nnmap('<leader>fbb',  "<cmd>lua require('fzf-lua').buffers()<CR>")
nnmap('<leader>fbl',  "<cmd>lua require('fzf-lua').blines()<CR>")
nnmap('<leader>fl',   "<cmd>lua require('fzf-lua').lines()<CR>")
nnmap('<leader>fh',   "<cmd>lua require('fzf-lua').help_tags()<CR>")
nnmap('<leader>fk', "<cmd>lua require('fzf-lua').man_pages()<CR>")
nnmap('<leader>fm', "<cmd>lua require('fzf-lua').marks()<CR>")
nnmap('<leader>fH',   "<cmd>lua require('fzf-lua').command_history()<CR>")
