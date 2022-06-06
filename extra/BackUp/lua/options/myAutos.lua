-- ##################################################
--  Autocommands
-- ##################################################

local api = vim.api

local MyReloadVIMRCGroup = api.nvim_create_augroup("MyReloadVIMRCGroup", { clear = true })
api.nvim_create_autocmd(
  { "BufWritePost" },
  { pattern = {"init.vim","init.lua"}, command = [[source $MYVIMRC | echom "Reloaded init.vim"]], group = MyreloadVIMRCGroup }
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
  { "FileType" },
  { pattern = "qf", command = "setlocal wrap", group = MyCommentsGroup }
)
api.nvim_create_autocmd(
  { "BufEnter" },
  { pattern = "vifmrc", command = [[setlocal commentstring=\"\ %s]], group = MyCommentsGroup }
)

-- Highlight on yank
local MyYankHighlightGroup = api.nvim_create_augroup("MyYankHighlightGroup", { clear = true })
api.nvim_create_autocmd(
  "TextYankPost",
  {
    command = "silent! lua vim.highlight.on_yank()",
    group = MyYankHighlightGroup,
  }
)

-- go to last loc when opening a buffer
api.nvim_create_autocmd(
  "BufReadPost",
  { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
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
  }
)
-- api.nvim_create_autocmd(
--   { "Syntax" },
--   {
--     pattern = {"tmux","py","bash","zsh","sh","r","h","hh","hpp","cc","c","cpp","vim","nvim","lua","xml","html","xhtml","perl"},
--     command = [[normal zR]], group = MyCustomSettingsGroup
--   }
-- )

local MyFiletypeDetectGroup = api.nvim_create_augroup("MyFiletypeDetectGroup", { clear = true })
api.nvim_create_autocmd(
  { "BufNewFile","BufRead" },
  { pattern = "*.tmux", command = [[set filetype=tmux | set syntax=sh]], group = MyFiletypeDetectGroup }
)
api.nvim_create_autocmd(
  { "BufNewFile","BufRead" },
  { pattern = "Makefile*", command = [[set filetype=make]], group = MyFiletypeDetectGroup }
)

local MyTerminalEscapeMappingGroup = api.nvim_create_augroup("MyTerminalEscapeMappingGroup", { clear = true })
api.nvim_create_autocmd(
  { "TermOpen" },
  { pattern = "*", command = [[tnoremap <buffer> <Esc> <c-\><c-n>]], group = MyTerminalEscapeMappingGroup }
)
api.nvim_create_autocmd(
  { "TermOpen" },
  { pattern = "*", command = "set nonu", group = MyTerminalEscapeMappingGroup }
)
