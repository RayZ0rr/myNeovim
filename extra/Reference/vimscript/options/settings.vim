" set leader key
" nnoremap <Space> <Nop>
" nnoremap <silent> <Space>	    <Nop>
let g:mapleader = ","
let g:maplocalleader=" "

" syntax on
set breakindent
set termguicolors
set ignorecase
set smartcase
set nohlsearch
set inccommand=nosplit
set nowrap                              " Display long lines as just one line
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set cmdheight=2                         " More space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set shortmess+=c
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=8
set shiftwidth=2                        " number of auto-indent spaces
set softtabstop=2
set expandtab	                        " Insert 2 spaces for a tab
set scrolloff=4                         " Keep 4 lines below cursor before scrolling the screen vertically
set sidescrolloff=8                     " Keep 4 lines below cursor before scrolling the screen horizontally
set smartindent                         " Makes indenting smart
set number                              " Line numbers
set cursorline                          " Enable highlighting of the current line
set showmatch                      			" Highlight matching brace
set showtabline=2                       " Always show tabs
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
" set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set clipboard+=unnamedplus              " Copy paste between vim and everything else
set autochdir                           " Your working directory will always be the same as your working directory
set laststatus=2

if has("persistent_undo")
   let target_path = expand('~/.config/nvim/.undoDir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif

" Set in treesitter config (lua/plugins/treesitter/settings.lua)
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99
" set foldlevelstart=99

" We do this to prevent the loading of the system fzf.vim plugin. This is
" present at least on Arch/Manjaro/Void
set rtp-=/usr/share/vim/vimfiles

set pastetoggle=<leader>pp

set sessionoptions=blank,buffers,curdir,help,tabpages,winsize,winpos,terminal
" set sessionoptions+=globals,blank,buffers,curdir,help,tabpages,winsize
" set sessionoptions-=folds

set viewoptions=cursor,folds,slash,unix
let viewdir_path = expand('~/.config/nvim/.mkViewDir')
" create the directory and any parent directories
" if the location does not exist.
if !isdirectory(viewdir_path)
  call mkdir(viewdir_path, "p", 0700)
endif
set viewdir=$HOME/.config/nvim/.mkViewDir
" let mkvpath = expand('~/.config/nvim/.mkViewDir')
" let &viewdir=mkvpath

" auto source when writing to init.vim
" alternatively you can run :source $MYVIMRC
augroup reloadVIMRCandSettings
  autocmd!
  au BufWritePost $MYVIMRC nested source $MYVIMRC | echom "Reloaded init.vim"
  " same for this settings file
  au BufWritePost **/settings.vim nested source $MYVIMRC | echom "Reloaded init.vim"
augroup end

"THEMES------------------------------------------------------------------
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
