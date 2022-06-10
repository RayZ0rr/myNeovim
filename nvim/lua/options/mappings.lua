-- local nmap = function(key,action)
--   vim.api.nvim_set_keymap('n',key,action,{noremap = false})
-- end

-- local bnnmap = function(key,action)
--   vim.api.nvim_buf_set_keymap(0,'n',key,action,{noremap = true})
-- end

-- local snnmap = function(key,action)
--   vim.api.nvim_set_keymap('n',key,action,{noremap = true, silent = true})
-- end

-- local nnmap = function(key,action)
--   vim.api.nvim_set_keymap('n',key,action,{noremap = true})
-- end

-- local inmap = function(key,action)
--   vim.api.nvim_set_keymap('i',key,action,{noremap = true})
-- end

-- local vnmap = function(key,action)
--   vim.api.nvim_set_keymap('v',key,action,{noremap = true})
-- end

-- local xnmap = function(key,action)
--   vim.api.nvim_set_keymap('x',key,action,{noremap = true})
-- end

local map = require('options/utils').map
local bmap = require('options/utils').bmap
local nnmap = require('options/utils').nnmap
local inmap = require('options/utils').inmap
local vnmap = require('options/utils').vnmap
local xnmap = require('options/utils').xnmap

nnmap('<leader>kl', [[:s/chakkachakkachakka/chakka/e<CR>]])

-----------------------------------------------------------------------------//
-- Add Empty space above and below
-----------------------------------------------------------------------------//
nnmap('[<space>', [[<cmd>put! =repeat(nr2char(10), v:count1)<cr>'[]])
nnmap(']<space>', [[<cmd>put =repeat(nr2char(10), v:count1)<cr>]])

-----------------------------------------------------------------------------//
-- Paste in visual mode multiple times
xnmap('p', 'pgvy')

-----------------------------------------------------------------------------//
-- Capitalize
-----------------------------------------------------------------------------//
nnmap('<leader>U', 'gUiw`]')
inmap('<C-u>', '<cmd>norm!gUiw`]a<CR>')

-----------------------------------------------------------------------------//
-- Select till end of line
-----------------------------------------------------------------------------//
xnmap('<space>', 'g_')

-----------------------------------------------------------------------------//
-- Open terminal buffer
-----------------------------------------------------------------------------//
nnmap("<leader>tr",":terminal<cr>A")

-----------------------------------------------------------------------------//
-- Netrw Explorer  on the left (:h :Lexplore)
-----------------------------------------------------------------------------//
nnmap( "<leader>tf", ":Lex 30<cr>")

-----------------------------------------------------------------------------//
-- open a new file in the same directory
-----------------------------------------------------------------------------//
-- nnmap('<leader>nf', [[:e <C-R>=expand("%:p:h") . "/" <CR>]], { silent = false })
nnmap('<leader>nf',[[:e <C-R>=expand("%:p:h") . "/" <CR>]])

-- local savefunc = function()
--   -- NOTE: this uses write specifically because we need to trigger a filesystem event
--   -- even if the file isn't change so that things like hot reload work
--   vim.cmd[[ 'silent! write' ]]
--   vim.notify('Saved ' .. vim.fn.expand '%:t', nil, { timeout = 1000 })
-- end

-----------------------------------------------------------------------------//
-- Save
-----------------------------------------------------------------------------//
-- nnmap('<c-s>', [[<cmd>lua require"mappings/extra".savefunc()<cr>]])

------------------------------------------------------------------------------
-- Quickfix
------------------------------------------------------------------------------
local toggle_qf = function()
  local gf_open = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      gf_open = true
    end
  end

  if gf_open then
    vim.cmd([[cclose]])
    return
  end
  vim.cmd([[copen]])
end
nnmap(',cc',toggle_qf)
nnmap(']q', '<cmd>cnext<CR>zz')
nnmap('[q', '<cmd>cprev<CR>zz')
nnmap(']l', '<cmd>lnext<cr>zz')
nnmap('[l', '<cmd>lprev<cr>zz')

-----------------------------------------------------------------------------//
-- Diable higlight
-----------------------------------------------------------------------------//
bmap('n','<localleader>hl' , ':set hlsearch!<CR>')

-----------------------------------------------------------------------------//
-- Toggle line wrap
-----------------------------------------------------------------------------//
nnmap('<localleader>wr' , ':setlocal wrap!<cr>')

-----------------------------------------------------------------------------//
-- Remap for dealing with word wrap
-----------------------------------------------------------------------------//
nnmap('k', "v:count == 0 ? 'gk' : 'k'", {expr = true})
nnmap('j', "v:count == 0 ? 'gj' : 'j'", {expr = true})

-----------------------------------------------------------------------------//
-- Use alt + hjkl to resize windows
-----------------------------------------------------------------------------//
nnmap('<M-UP>' , ':resize -2<CR>')
nnmap('<M-DOWN>' , ':resize +2<CR>')
nnmap('<M-LEFT>' , ':vertical resize -2<CR>')
nnmap('<M-RIGHT>' , ':vertical resize +2<CR>')

-----------------------------------------------------------------------------//
-- Easy CAPS toggle
-----------------------------------------------------------------------------//
nnmap('<Leader><c-u>' , 'viw~<Esc>')

-----------------------------------------------------------------------------//
-- Search and replace
-----------------------------------------------------------------------------//

-- Replace -------------------
nnmap('<Leader>sr' , ':%s/<C-r><C-w>//gc<Left><Left><Left>',{silent = false})
vnmap('<Leader>sr' , 'y:%s/<C-R>"//gc<Left><Left><Left>',{silent = false})
vnmap('<Leader>vsr' , [[:s/\%V<C-r>"\%V//gc<Left><Left><Left>]],{silent = false})
-- vnmap('<Leader>vsr' , [[:s/<C-r>"//gc<Left><Left><Left>]])
-- nnmap('<Leader><leader>sr' , [[:%s/\%V<C-r>"//gc<Left><Left><Left>]])

-- Search -------------------
vnmap('//', [[y/<C-R>"<CR>]],{silent = false})
vnmap('<Leader>ss' , [[y/<C-R>"<CR>]],{silent = false})
-- makes * and # work on visual mode too.
vim.api.nvim_exec(
  [[
  function! g:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
  endfunction

  xnoremap * :<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
  ]],
  false
)

-----------------------------------------------------------------------------//
-- TAB/SHIFT-TAB in general mode will move to next/prev buffer
-----------------------------------------------------------------------------//
nnmap('<M-s>' , ':bnext<CR>')
nnmap('<M-a>' , ':bprevious<CR>')
inmap('<M-s>' , '<Esc>:bnext<CR>')
inmap('<M-a>' , '<esc>:bprevious<CR>')

-----------------------------------------------------------------------------//
-- Use control-c instead of escape
-----------------------------------------------------------------------------//
nnmap('<C-c>' , '<Esc>')
inmap('<C-C>' , '<ESC>')

-----------------------------------------------------------------------------//
-- Alternate way to save and quit
-----------------------------------------------------------------------------//
nnmap('<C-s>' , '<cmd>confirm w<CR>')
nnmap('<c-q>' , ':confirm q<CR>')

-----------------------------------------------------------------------------//
-- Close buffer
-----------------------------------------------------------------------------//
nnmap('<Leader>qq' , ':bn<bar>bd#<CR>')
-- Close all buffer except current
nnmap('<Leader>bq' , ':%bd<bar>e#<bar>bd#<cr>')

-----------------------------------------------------------------------------//
-- Better tabbing
-----------------------------------------------------------------------------//
vnmap('<' , '<gv')
vnmap('>' , '>gv')

-----------------------------------------------------------------------------//
-- Move selected line / block of text in visual mode
-----------------------------------------------------------------------------//
nnmap('<S-Down>', ':m .+1<CR>==')
nnmap('<S-Up>', [[:m .-2<CR>==]])
inmap('<S-Down>', '<Esc>:m .+1<CR>==gi')
inmap('<S-Up>', '<Esc>:m .-2<CR>==gi')
vnmap('<S-Down>', ':m \'>+1<CR>gv=gv')
vnmap('<S-Up>', ':m \'<-2<CR>gv=gv')

-----------------------------------------------------------------------------//
-- Better window navigation
-----------------------------------------------------------------------------//
nnmap('<C-h>' , '<C-w>h')
nnmap('<C-j>' , '<C-w>j')
nnmap('<C-k>' , '<C-w>k')
nnmap('<C-l>' , '<C-w>l')

nnmap('<C-Left>' , '<C-w>h')
nnmap('<C-Down>' , '<C-w>j')
nnmap('<C-Up>' , '<C-w>k')
nnmap('<C-Right>' , '<C-w>l')

-----------------------------------------------------------------------------//
-- Mapping to show filetype, buftype and highlight
-----------------------------------------------------------------------------//
nnmap('<leader>dt',[[<cmd>lua vim.ui.select({"hi", "set buftype?", "set filetype?"}, {}, function (choice) vim.cmd(choice) end)<cr>]])
