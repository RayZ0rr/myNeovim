-- ##################################################
--  Autocommands
-- ##################################################

local api = vim.api
local map = require('options/utils').map
local bmap = require('options/utils').bmap
local nnmap = require('options/utils').nnmap
local inmap = require('options/utils').inmap
local vnmap = require('options/utils').vnmap
local xnmap = require('options/utils').xnmap
local tnmap = require('options/utils').tnmap

local MyReloadVIMRCGroup = api.nvim_create_augroup("MyReloadVIMRCGroup", { clear = true })
api.nvim_create_autocmd(
  { "BufWritePost" },
  { pattern = {"init.vim","~/.config/nvim/init.lua"}, command = [[source $MYVIMRC | echom "Reloaded init.vim"]], group = MyreloadVIMRCGroup }
)
api.nvim_create_autocmd(
  { "BufWritePost" },
  { pattern = "**/lua/options/settings.lua", command = [[source $MYVIMRC | echom "Reloaded init.vim"]], group = MyreloadVIMRCGroup }
)

local MyCommentsGroup = api.nvim_create_augroup("MyCommentsGroup", { clear = true })
api.nvim_create_autocmd(
  { "BufNewFile","BufRead" },
  { pattern = "**/.Xresources.d/*", command = [[setlocal commentstring=!\ %s]], group = MyCommentsGroup }
)
api.nvim_create_autocmd(
  { "BufNewFile","BufRead" },
  { pattern = "**/.Xresources", command = [[setlocal commentstring=!\ %s]], group = MyCommentsGroup }
)
api.nvim_create_autocmd(
  { "BufNewFile","BufRead" },
  { pattern = "/etc/**/*.conf", command = [[setlocal commentstring=#\ %s]], group = MyCommentsGroup }
)
api.nvim_create_autocmd(
  { "BufNewFile","BufRead" },
  { pattern = "Makefile*", command = [[setlocal commentstring=#\ %s]], group = MyCommentsGroup }
)
api.nvim_create_autocmd(
  { "FileType" },
  { pattern = "xdefaults", command = [[setlocal commentstring=!\ %s]], group = MyCommentsGroup }
)
api.nvim_create_autocmd(
  { "FileType" },
  { pattern = "apache", command = [[setlocal commentstring=#\ %s]], group = MyCommentsGroup }
)
api.nvim_create_autocmd(
  { "BufEnter" },
  { pattern = {"vifmrc","*.vifm"}, command = [[setlocal commentstring=\"\ %s]], group = MyCommentsGroup }
)

api.nvim_set_hl(0,"YankHighlightGroup",{fg='#4B4B4B' , bg="#e5c07b" })
-- Highlight on yank
local MyYankHighlightGroup = api.nvim_create_augroup("MyYankHighlightGroup", { clear = true })
api.nvim_create_autocmd(
  "TextYankPost",
  {
    command = "silent! lua vim.highlight.on_yank({higroup='YankHighlightGroup'})",
    group = MyYankHighlightGroup,
  }
)

-- show cursor line only in active window
local MyCursorLineGroup = api.nvim_create_augroup("MyCursorLineGroup", { clear = true })
api.nvim_create_autocmd(
  { "InsertLeave", "WinEnter" },
  { pattern = "*", command = "set cursorline", group = MyCursorLineGroup }
)
api.nvim_create_autocmd(
  { "InsertEnter", "WinLeave" },
  { pattern = "*", command = "set nocursorline", group = MyCursorLineGroup }
)

local MyCustomSettingsGroup = api.nvim_create_augroup("MyCustomSettingsGroup", { clear = true })
api.nvim_create_autocmd(
  { "BufNewFile","BufRead" },
  { pattern = "*", command = "set formatoptions-=cro", group = MyCustomSettingsGroup }
)
api.nvim_create_autocmd(
  { "BufNewFile","BufRead" },
  { pattern = {"/tmp/*","~/tmp/*","~/.cache/*"}, command = "setlocal noundofile", group = MyCustomSettingsGroup }
)
api.nvim_create_autocmd(
  { 'BufRead', 'BufNewFile' },
  {
    pattern = { '*.md' },
    command = 'setlocal wrap spell spelllang=en_us nonumber',
    group = MyCustomSettingsGroup
  }
)
-- api.nvim_create_autocmd( "BufWritePost" , {
--   group = MyCustomSettingsGroup,
--   pattern = "*",
--   callback = function()
--     if vim.fn.getline(1) == "^#!" then
--       if vim.fn.getline(1) == "/bin/" then
-- 	vim.cmd([[chmod a+x <afile>]])
--       end
--     end
--   end,
--   once = false,
-- })

api.nvim_create_autocmd(
  {"BufEnter", "FileType"},
  {
    group = MyCustomSettingsGroup,
    desc = "don't auto comment new line",
    pattern = "*",
    command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
  }
)

api.nvim_create_autocmd(
  "VimResized",
  {
    group = MyCustomSettingsGroup,
    desc = "auto resize splited windows",
    pattern = "*",
    command = "tabdo wincmd =",
  }
)

api.nvim_create_autocmd(
  "BufWinEnter",
  {
    group = MyCustomSettingsGroup,
    desc = "clear the last used search pattern",
    pattern = "*",
    command = "let @/ = ''",
  }
)
-- api.nvim_create_autocmd(
--   "BufReadPost",
--   {
--     group = MyCustomSettingsGroup,
--     desc = "go to last loc when opening a buffer",
--     pattern = "*",
--     command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
--   }
-- )
api.nvim_create_autocmd(
  "BufReadPost",
  {
    group = MyCustomSettingsGroup,
    desc = "go to last loc when opening a buffer",
    callback = function()
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local lcount = vim.api.nvim_buf_line_count(0)
      if mark[1] > 0 and mark[1] <= lcount then
	pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end,
  }
)
-- api.nvim_create_autocmd(
--   { "Syntax" },
--   {
--     pattern = {"tmux","py","bash","zsh","sh","r","h","hh","hpp","cc","c","cpp","vim","nvim","lua","xml","html","xhtml","perl"},
--     command = [[normal zR]], group = MyCustomSettingsGroup
--   }
-- )

local MyQuickFixGroup = api.nvim_create_augroup("MyQuickFixGroup", { clear = true })
-- api.nvim_create_autocmd(
--   "QuickFixCmdPost",
--   { command = "cgetexpr cwindow", group = MyQuickFixGroup }
-- )
-- api.nvim_create_autocmd(
--   "QuickFixCmdPost",
--   { command = "lgetexpr lwindow", group = MyQuickFixGroup }
-- )
-- vim.api.nvim_create_autocmd( "FileType" , {
--   group = MyQuickFixGroup,
--   pattern = { "qf" },
--   callback = function()
--     vim.opt_local.wrap = true
--     vim.keymap.set('n','<Leader>sr' , [[:cfdo %s/<C-r><C-w>//gc | update <C-Left><C-Left><Left><Left><Left><Left>]],{buffer=true,desc="qf search and replace cword"})
--     vim.keymap.set('v','<Leader>sr' , 'y:cfdo %s/<C-R>"//gc | update <C-Left><C-Left><Left><Left><Left><Left>',{buffer=true,desc="qf search and replace selection"})
--     vim.keymap.set('v','<Leader>vsr' , [[:cfdo s/\%V<C-r>"\%V//gc | update <C-Left><C-Left><Left><Left><Left><Left>]],{buffer=true,desc="qf search and replace range"})
--   end,
--   once = false,
-- })
-- vim.cmd([[
-- augroup myQuickfixFix
--   autocmd!
--   autocmd QuickFixCmdPost cgetexpr cwindow
--   autocmd QuickFixCmdPost lgetexpr lwindow
-- augroup END
-- ]])
-- vim.api.nvim_create_autocmd({ "QuickfixCmdPost" }, {
--   group = MyQuickFixGroup,
--   pattern = { "make", "grep", "grepadd", "vimgrep", "vimgrepadd" },
--   callback = function()
--     vim.cmd([[cwin]])
--   end,
--   once = false,
-- })
-- vim.api.nvim_create_autocmd({ "QuickfixCmdPost" }, {
--   group = MyQuickFixGroup,
--   pattern = { "lmake", "lgrep", "lgrepadd", "lvimgrep", "lvimgrepadd" },
--   callback = function()
--     vim.cmd([[lwin]])
--   end,
--   once = false,
-- })

local MyFiletypeDetectGroup = api.nvim_create_augroup("MyFiletypeDetectGroup", { clear = true })
api.nvim_create_autocmd(
  { "BufNewFile","BufRead" },
  { pattern = "*.tmux", command = [[set filetype=tmux | set syntax=sh]], group = MyFiletypeDetectGroup }
)
api.nvim_create_autocmd(
  { "BufNewFile","BufRead" },
  { pattern = "Makefile*", command = [[set filetype=make]], group = MyFiletypeDetectGroup }
)

local MyTerminalGroup = api.nvim_create_augroup("MyTerminalGroup", { clear = true })
api.nvim_create_autocmd(
  "TermOpen" ,
  { command = [[tnoremap <buffer> <Esc> <c-\><c-n>]], group = MyTerminalGroup }
)
api.nvim_create_autocmd(
  "TermOpen",
  {
    callback = function()
      vim.cmd([[
	setlocal nonumber
	setlocal nospell
	setlocal norelativenumber
	setlocal signcolumn=no
	setlocal ft=term
      ]])
    end,
    group = MyTerminalGroup
  }
)
