local map = require('config/options/utils').map
local bmap = require('config/options/utils').bmap
local nnmap = require('config/options/utils').nnmap
local inmap = require('config/options/utils').inmap
local vnmap = require('config/options/utils').vnmap
local xnmap = require('config/options/utils').xnmap
local tnmap = require('config/options/utils').tnmap

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", {desc = "Clear hlsearch and escape"})
nnmap("<leader>cd", [[<cmd>lcd %:p:h<cr><cmd>pwd<cr>]], {desc = "change cwd"})

-----------------------------------------------------------------------------//
-- Add Empty space above and below
-----------------------------------------------------------------------------//
nnmap('[<space>', [[<cmd>put! =repeat(nr2char(10), v:count1)<cr>'[]],
    {desc = "Add empty space above"})
nnmap(']<space>', [[<cmd>put =repeat(nr2char(10), v:count1)<cr>]],
    {desc = "Add empty space below"})

-----------------------------------------------------------------------------//
-- Paste in visual mode multiple times
-----------------------------------------------------------------------------//
nnmap("<leader>D", [["_D]], {desc = "blackhole 'D'"})
nnmap("<leader>C", [["_C]], {desc = "blackhole 'C'"})

-----------------------------------------------------------------------------//
-- Change cases (upper/lower case toggle)
-----------------------------------------------------------------------------//
nnmap('<leader><c-u>', 'g~iw`]')
inmap('<C-u>', '<cmd>norm!g~iw`]a<CR>')

-----------------------------------------------------------------------------//
-- Some insert mode conveniences
-----------------------------------------------------------------------------//
-- Go to the begining and end of current line in insert mode quickly
inmap('<C-A>', '<HOME>')
inmap('<C-E>', '<END>')
-- Shift tab
inmap("<S-TAB>", "<ESC><<<Ins>")

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
tnmap( '<Esc>', [[<C-\><C-n>]])
nnmap( '<leader>ty', [[<cmd>split<bar>below<cr><cmd>resize 10<bar>term<CR>]])

-----------------------------------------------------------------------------//
-- Netrw Explorer  on the left (:h :Lexplore)
-----------------------------------------------------------------------------//
nnmap( "<leader>tf", ":Lex 30<cr>")

-----------------------------------------------------------------------------//
-- open a new file in the same directory
-----------------------------------------------------------------------------//
nnmap('<leader>nf',[[:e <C-R>=expand("%:p:h") . "/"<CR>]],
    {silent = false, desc="Open new file in current directory"})

-----------------------------------------------------------------------------//
-- Diable higlight
-----------------------------------------------------------------------------//
nnmap('<localleader>hl' , [[<cmd>set hlsearch!<CR>]])
nnmap(
  "<leader>hl",
  [[<Cmd>set hlsearch!<Bar>diffupdate<Bar>normal! <C-L><CR>]],
  { desc = "Redraw / clear hlsearch / diff update" }
)

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
nnmap('<S-UP>', "<cmd>resize +2<cr>", { desc = "Increase window height" })
nnmap('<S-DOWN>', "<cmd>resize -2<cr>", { desc = "Decrease window height" })
nnmap('<S-LEFT>', "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
nnmap('<S-RIGHT>', "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-----------------------------------------------------------------------------//
-- Move selected line / block of text in visual mode
-----------------------------------------------------------------------------//
nnmap('<A-DOWN>', ":m .+1<cr>==", { desc = "Move down" })
nnmap('<A-UP>', ":m .-2<cr>==", { desc = "Move up" })
inmap('<A-DOWN>', "<Esc>:m .+1<cr>==gi", { desc = "Move down" })
inmap('<A-UP>', "<Esc>:m .-2<cr>==gi", { desc = "Move up" })
vnmap('<A-DOWN>', ":m '>+1<cr>gv=gv", { desc = "Move down" })
vnmap('<A-UP>', ":m '<-2<cr>gv=gv", { desc = "Move up" })

-----------------------------------------------------------------------------//
-- Better window navigation
-----------------------------------------------------------------------------//
nnmap("<C-LEFT>", "<C-w><C-h>", { desc = "Navigate windows to the left"} )
nnmap("<C-DOWN>", "<C-w><C-j>", { desc = "Navigate windows down"} )
nnmap("<C-UP>", "<C-w><C-k>", { desc = "Navigate windows up"} )
nnmap("<C-RIGHT>", "<C-w><C-l>", { desc = "Navigate windows to the right"} )

-----------------------------------------------------------------------------//
-- Move windows with shift-arrows
-----------------------------------------------------------------------------//
nnmap("<leader><S-Left>", "<C-w><S-h>", { desc = "Move window to the left"} )
nnmap("<leader><S-Down>", "<C-w><S-j>", { desc = "Move window down"} )
nnmap("<leader><S-Up>", "<C-w><S-k>", { desc = "Move window up"} )
nnmap("<leader><S-Right>", "<C-w><S-l>", { desc = "Move window to the right"} )

nnmap("<space><space>", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-----------------------------------------------------------------------------//
-- Search and replace
-----------------------------------------------------------------------------//
-- Replace -------------------
nnmap('<Leader>sr' , ':%s/<C-r><C-w>//gc<Left><Left><Left>', {silent = false, desc="search and replace cword"})
vnmap('<Leader>sr' , 'y:%s/<C-R>"//gc<Left><Left><Left>', {silent = false, desc="search and replace selection"})
vnmap('<Leader>vsr' , [[:s/\%V<C-r>"\%V//gc<Left><Left><Left>]], {silent = false, desc="search and replace range"})

-- Search -------------------
nnmap("gw", "*N")
xnmap("gw", "*N")

map({"n","x","o"}, "n", "'Nn'[v:searchforward]", {expr = true, desc = "Next search result"})
map({"n","x","o"}, "N", "'nN'[v:searchforward]", {expr = true, desc = "Prev search result"})

vnmap('<Leader>/', '<Esc>/\\%V',{silent = false})
-- makes * and # work on visual mode too.
-- vim.api.nvim_exec(
--   [[
--   function! s:getSelectedText()
--     let l:old_reg = getreg('"')
--     let l:old_regtype = getregtype('"')
--     norm gvy
--     let l:ret = getreg('"')
--     call setreg('"', l:old_reg, l:old_regtype)
--     exe "norm \<Esc>"
--     return l:ret
--   endfunction

--   vnoremap <silent> * :call setreg("/",
--       \ substitute(<SID>getSelectedText(),
--       \ '\_s\+',
--       \ '\\_s\\+', 'g')
--       \ )<Cr>n

--   vnoremap <silent> # :call setreg("?",
--       \ substitute(<SID>getSelectedText(),
--       \ '\_s\+',
--       \ '\\_s\\+', 'g')
--       \ )<Cr>n
--   ]],
--   false
-- )

-----------------------------------------------------------------------------//
-- TAB/SHIFT-TAB in general mode will move to next/prev buffer
-----------------------------------------------------------------------------//
map( {'n','i'}, '<A-s>' , '<cmd>bnext<CR>')
map( {'n','i'}, '<A-a>' , '<cmd>bprevious<CR>')

-----------------------------------------------------------------------------//
-- Use control-c instead of escape
-----------------------------------------------------------------------------//
map( {'n','i'}, '<C-c>' , '<Esc>')

-----------------------------------------------------------------------------//
-- Alternate way to save and quit
-----------------------------------------------------------------------------//
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
nnmap('<c-q>' , ':confirm q<CR>')
nnmap("<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

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
nnmap('<leader>dt',
    function()
        vim.ui.select({"hi", "set buftype?", "set filetype?"},
            {},
            function (choice) vim.cmd("ERedir " .. choice) end
        )
    end
)

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

------------------------------------------------------------------------------
-- Commenting
------------------------------------------------------------------------------
if vim.fn.has("nvim-0.10") then
    local keyname = "<C-/>"
    -- if string.find(vim.env['TERM'], "tmux") then
    --     keyname = "<C-_>"
    -- end
    map("n", keyname, "gcc", { remap = true })
    map("v", keyname, "gc", { remap = true })
end
