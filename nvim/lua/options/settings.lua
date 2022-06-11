local set = vim.opt
local g = vim.g

-- use filetype.lua instead of filetype.vim
g.did_load_filetypes = 0
g.do_filetype_lua = 1

-- set leader key
-- nnoremap <Space> <Nop>
-- nnoremap <silent> <Space>	    <Nop>
g.mapleader = ","
g.maplocalleader=" "

-- set.whichwrap:append "<>[]hl"
set.breakindent = true
set.termguicolors = true
set.ignorecase = true
set.smartcase = true
set.hlsearch = false
set.inccommand='nosplit'
set.wrap = false                        -- Display long lines as just one line
set.pumheight=10                        -- Makes popup menu smaller
set.fileencoding='utf-8'                -- The encoding written to file
set.cmdheight=2                         -- More space for displaying messages
vim.cmd[[set iskeyword+=-]]             -- treat dash separated words as a word text object
set.mouse='a'                           -- Enable your mouse
set.shortmess:append('c')		-- Avoid showing message extra message when using completion
set.splitbelow = true                   -- Horizontal splits will automatically be below
set.splitright = true                   -- Vertical splits will automatically be to the right
-- set.t_Co=256				-- Support 256 colors
set.conceallevel=0                      -- So that I can see `` in markdown files
set.tabstop=8
set.shiftwidth=2                        -- number of auto-indent spaces
set.softtabstop=2
-- set.expandtab = true			-- Insert 2 spaces for a tab
set.scrolloff=4                         -- Keep 4 lines below cursor before scrolling the screen vertically
set.sidescrolloff=8                     -- Keep 4 lines below cursor before scrolling the screen horizontally
set.smartindent = true                  -- Makes indenting smart
set.number = true                       -- Line numbers
set.cursorline = true                   -- Enable highlighting of the current line
set.showmatch = true                    -- " Highlight matching brace
set.showtabline=2                       -- Always show tabs
set.showmode = false                    -- We don't need to see things like -- INSERT -- anymore
set.updatetime=200			-- " Faster completion
set.timeoutlen=500                      -- By default timeoutlen is 1000 ms
-- vim.cmd[[set formatoptions=jql]]	-- Stop newline continution of comments
set.formatoptions:remove('o')		-- Automatically insert comment leader after 'o' or 'O' in Normal mode.
set.formatoptions:append('r')		-- Automatically insert comment leader after <Enter> in Insert mode.
set.formatoptions:append('l')		-- Long lines are not broken in insert mode.
set.formatoptions:remove('t')		-- Do not auto wrap text
set.formatoptions:append('n')		-- Recognise lists
set.clipboard='unnamedplus'		-- Copy paste between vim and everything else
set.autochdir = true                    -- Your working directory will always be the same as your working directory
set.laststatus=3			-- Global statusline
set.title = true
set.virtualedit    = 'block'		-- allow cursor to exist where there is no character
set.winblend       = 10
set.lazyredraw     = true

set.fillchars="fold: ,vert:│"

set.grepprg="rg --vimgrep"
set.grepformat = "%l:%c:%m"
-- set.grepformat:prepend{"%f:%l:%c:%m"}

set.undofile = true
local undoPath = vim.fn.stdpath('config') .. '/.undoDir'
if vim.fn.isdirectory(undoPath) == 0 then
  vim.fn.system {
    'mkdir',
    '-p',
    undoPath
  }
end
set.undodir=undoPath

-- Set in lua/treesitter/settings.lua
-- set.foldmethod='syntax'
-- set.foldlevelstart=99

-- We do this to prevent the loading of the system fzf.vim plugin. This is
-- present at least on Arch/Manjaro/Void
vim.cmd[[set rtp-=/usr/share/vim/vimfiles]]

set.pastetoggle='<leader>pp'

set.sessionoptions="blank,buffers,curdir,help,tabpages,winsize,winpos,terminal"
-- vim.cmd[[set sessionoptions+=globals,blank,buffers,curdir,help,tabpages,winsize]]
-- vim.cmd[[set sessionoptions-=folds]]

set.viewoptions="cursor,folds,slash,unix"
local viewPath = vim.fn.stdpath('config') .. '/.mkViewDir'
if vim.fn.isdirectory(viewPath) == 0 then
  vim.fn.system {
    'mkdir',
    '-p',
    viewPath
  }
end
set.viewdir=viewPath

local disable_distribution_plugins = function()
  g.did_load_fzf = 1
  g.did_load_gtags = 1
  g.did_load_gzip = 1
  g.did_load_tar = 1
  g.did_load_tarPlugin = 1
  g.did_load_zip = 1
  g.did_load_zipPlugin = 1
  g.did_load_getscript = 1
  g.did_load_getscriptPlugin = 1
  g.did_load_vimball = 1
  g.did_load_vimballPlugin = 1
  g.did_load_matchit = 1
  g.did_load_matchparen = 1
  g.did_load_2html_plugin = 1
  g.did_load_logiPat = 1
  g.did_load_rrhelper = 1
  g.did_load_netrw = 1
  g.did_load_netrwPlugin = 1
  g.did_load_netrwSettings = 1
  g.did_load_netrwFileHandlers = 1
end
disable_distribution_plugins()
