local map = require('options/utils').map
local bmap = require('options/utils').bmap
local nnmap = require('options/utils').nnmap
local inmap = require('options/utils').inmap
local vnmap = require('options/utils').vnmap
local xnmap = require('options/utils').xnmap
local tnmap = require('options/utils').tnmap

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr>", { desc = "Escape and clear hlsearch" })

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
-- Some insert mode conveniences
-----------------------------------------------------------------------------//
-- Go to the begining and end of current line in insert mode quickly
inmap('<C-A>', '<HOME>')
inmap('<C-E>', '<END>')

-- Delete the character to the right of the cursor
inmap('<C-D>', '<DEL>')

-----------------------------------------------------------------------------//
-- Select till end of line
-----------------------------------------------------------------------------//
xnmap('<space>', 'g_')

-----------------------------------------------------------------------------//
-- Open terminal buffer
-----------------------------------------------------------------------------//
nnmap("<leader>tr",":terminal<cr>")
tnmap( '<C-h>', [[<C-\><C-N><C-h>]] )
tnmap( '<C-l>', [[<C-\><C-N><C-l>]] )
tnmap( '<C-j>', [[<C-\><C-N><C-j>]] )
tnmap( '<C-k>', [[<C-\><C-N><C-k>]] )
tnmap( '<Esc>', [[<C-\><C-n>]], {buffer=true})
nnmap( '<leader>ty', [[:split<bar>below<bar>resize 10<bar>term<CR>]])

-----------------------------------------------------------------------------//
-- Netrw Explorer  on the left (:h :Lexplore)
-----------------------------------------------------------------------------//
nnmap( "<leader>tf", ":Lex 30<cr>")

-----------------------------------------------------------------------------//
-- open a new file in the same directory
-----------------------------------------------------------------------------//
nnmap('<leader>nf',[[<cmd>e <C-R>=expand("%:p:h") . "/" <CR>]])

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
nnmap('<up>', "v:count == 0 ? 'gk' : '<up>'", {expr = true})
nnmap('<down>', "v:count == 0 ? 'gj' : '<down>'", {expr = true})

-----------------------------------------------------------------------------//
-- Use alt + arrow keys to resize windows
-----------------------------------------------------------------------------//
nnmap('<M-UP>' , "<cmd>resize +2<cr>", { desc = "Increase window height" })
nnmap('<M-DOWN>' , "<cmd>resize -2<cr>", { desc = "Decrease window height" })
nnmap('<M-LEFT>' , "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
nnmap('<M-RIGHT>' , "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-----------------------------------------------------------------------------//
-- Move selected line / block of text in visual mode
-----------------------------------------------------------------------------//
nnmap('<S-Down>' , ":m .+1<cr>==", { desc = "Move down" })
nnmap('<S-Up>'   , ":m .-2<cr>==", { desc = "Move up" })
inmap('<S-Down>' , "<Esc>:m .+1<cr>==gi", { desc = "Move down" })
inmap('<S-Up>'   , "<Esc>:m .-2<cr>==gi", { desc = "Move up" })
vnmap('<S-Down>' , ":m '>+1<cr>gv=gv", { desc = "Move down" })
vnmap('<S-Up>'   , ":m '<-2<cr>gv=gv", { desc = "Move up" })

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

nnmap("<space><space>", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
nnmap("gw", "*N")
xnmap("gw", "*N")

-----------------------------------------------------------------------------//
-- Easy CAPS toggle
-----------------------------------------------------------------------------//
nnmap('<Leader><c-u>' , 'viw~<Esc>')

map({"n","x","o"}, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map({"n","x","o"}, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-----------------------------------------------------------------------------//
-- Search and replace
-----------------------------------------------------------------------------//

-- Replace -------------------
nnmap('<Leader>sr' , ':%s/<C-r><C-w>//gc<Left><Left><Left>',{silent = false,desc="search and replace cword"})
vnmap('<Leader>sr' , 'y:%s/<C-R>"//gc<Left><Left><Left>',{silent = false,desc="search and replace selection"})
vnmap('<Leader>vsr' , [[:s/\%V<C-r>"\%V//gc<Left><Left><Left>]],{silent = false,desc="search and replace range"})

-- Search -------------------
vnmap('//', '<Esc>/\\%V',{silent = false})
-- makes * and # work on visual mode too.
vim.api.nvim_exec(
  [[
  function! s:getSelectedText()
    let l:old_reg = getreg('"')
    let l:old_regtype = getregtype('"')
    norm gvy
    let l:ret = getreg('"')
    call setreg('"', l:old_reg, l:old_regtype)
    exe "norm \<Esc>"
    return l:ret
  endfunction

  vnoremap <silent> * :call setreg("/",
      \ substitute(<SID>getSelectedText(),
      \ '\_s\+',
      \ '\\_s\\+', 'g')
      \ )<Cr>n

  vnoremap <silent> # :call setreg("?",
      \ substitute(<SID>getSelectedText(),
      \ '\_s\+',
      \ '\\_s\\+', 'g')
      \ )<Cr>n
  ]],
  false
)

-----------------------------------------------------------------------------//
-- TAB/SHIFT-TAB in general mode will move to next/prev buffer
-----------------------------------------------------------------------------//
map( {'n','i'}, '<M-s>' , '<cmd>bnext<CR>')
map( {'n','i'}, '<M-a>' , '<cmd>bprevious<CR>')

-----------------------------------------------------------------------------//
-- Use control-c instead of escape
-----------------------------------------------------------------------------//
map( {'n','i'}, '<C-c>' , '<Esc>')

-----------------------------------------------------------------------------//
-- Alternate way to save and quit
-----------------------------------------------------------------------------//
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
nnmap('<c-q>' , ':confirm q<CR>')

-----------------------------------------------------------------------------//
-- Save
-----------------------------------------------------------------------------//
-- local savefunc = function()
--   -- NOTE: this uses write specifically because we need to trigger a filesystem event
--   -- even if the file isn't change so that things like hot reload work
--   vim.cmd[[ 'silent! write' ]]
--   vim.notify('Saved ' .. vim.fn.expand '%:t', nil, { timeout = 1000 })
-- end
-- nnmap('<c-s>', [[<cmd>lua require"mappings/extra".savefunc()<cr>]])

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
-- Mapping to show filetype, buftype and highlight
-----------------------------------------------------------------------------//
nnmap('<leader>dt',[[<cmd>lua vim.ui.select({"hi", "set buftype?", "set filetype?"}, {}, function (choice) vim.cmd(choice) end)<cr>]])

------------------------------------------------------------------------------
-- Quickfix
------------------------------------------------------------------------------
-- local toggle_qf = function()
--   local gf_open = false
--   for _, win in pairs(vim.fn.getwininfo()) do
--     if win["quickfix"] == 1 then
--       gf_open = true
--     end
--   end

--   if gf_open then
--     vim.cmd([[cclose]])
--     return
--   end
--   vim.cmd([[copen]])
-- end
-- nnmap(',qt',toggle_qf)
nnmap('=l', function()
    local win = vim.api.nvim_get_current_win()
    local qf_winid = vim.fn.getloclist(win, { winid = 0 }).winid
    local action = qf_winid > 0 and 'lclose' or 'lopen'
    vim.cmd(action)
end, { desc = "Toggle locationlist window." })
nnmap('=q', function()
    local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
    local action = qf_winid > 0 and 'cclose' or 'copen'
    vim.cmd(action)
end, { desc = "Toggle quickfix window." })
nnmap(']q', '<cmd>cnext<CR>zz')
nnmap('[q', '<cmd>cprev<CR>zz')
nnmap(']l', '<cmd>lnext<cr>zz')
nnmap('[l', '<cmd>lprev<cr>zz')
