local opt = vim.opt
local g = vim.g

-- set leader key
g.mapleader = ","
g.maplocalleader=" "

-- opt.whichwrap:append "<>[]hl"
opt.breakindent = true
opt.termguicolors = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.inccommand='nosplit'
opt.wrap = false                        -- Display long lines as just one line
opt.wildoptions:append("pum")
opt.wildmenu = true                   -- Enhanced command completion
opt.wildmode = "longest,list,full"
opt.pumblend = 10			-- Popup blend
opt.pumheight=10                        -- Makes popup menu smaller
opt.fileencoding='utf-8'                -- The encoding written to file
opt.cmdheight=2                         -- More space for displaying messages
vim.cmd[[set iskeyword+=-]]             -- treat dash separated words as a word text object
opt.mouse='a'                           -- Enable your mouse
opt.shortmess:append('c')		-- Avoid showing message extra message when using completion
opt.splitbelow = true                   -- Horizontal splits will automatically be below
opt.splitright = true                   -- Vertical splits will automatically be to the right
-- opt.t_Co=256				-- Support 256 colors
opt.conceallevel=0                      -- So that I can see `` in markdown files
opt.tabstop=8
opt.shiftwidth=4                        -- number of auto-indent spaces
opt.softtabstop=-1
opt.expandtab = true			-- Insert 2 spaces for a tab
opt.smarttab = false			-- Use shiftwidth space for start and tab elsewhere
opt.scrolloff=4                         -- Keep 4 lines below cursor before scrolling the screen vertically
opt.sidescrolloff=8                     -- Keep 4 lines below cursor before scrolling the screen horizontally
opt.smartindent = true                  -- Makes indenting smart
opt.number = true                       -- Line numbers
opt.cursorline = false                   -- Enable highlighting of the current line
opt.showmatch = true                    -- " Highlight matching brace
opt.showtabline=2                       -- Always show tabs
opt.showmode = false                    -- We don't need to see things like -- INSERT -- anymore
opt.updatetime=200			-- " Faster completion
opt.timeoutlen=300                      -- By default timeoutlen is 1000 ms
-- vim.cmd[[set formatoptions=jql]]	-- Stop newline continution of comments
opt.formatoptions:remove('o')		-- Automatically insert comment leader after 'o' or 'O' in Normal mode.
opt.formatoptions:remove('t')		-- Do not auto wrap text
opt.formatoptions:append('r')		-- Automatically insert comment leader after <Enter> in Insert mode.
opt.formatoptions:append('l')		-- Long lines are not broken in insert mode.
opt.formatoptions:append('n')		-- Recognise lists
opt.clipboard:append('unnamedplus')	-- Copy paste between vim and everything else
-- vim.cmd[[set clipboard+=unnamedplus]]	-- Copy paste between vim and everything else
opt.autochdir = true                    -- Your working directory will always be the same as your working directory
opt.laststatus=2			-- Global statusline
opt.title = true
opt.virtualedit    = 'block'		-- allow cursor to exist where there is no character
opt.winblend       = 10
opt.lazyredraw     = true
opt.backspace = { 'eol', 'start', 'indent' } -- Without this option some times backspace did not work correctly.

opt.list = true
opt.listchars = {
    nbsp = '⦸', -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
    extends = '»', -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
    precedes = '«', -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
    -- tab = '▷─', -- '▷─' WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
    tab = '▸-',
    trail = '•', -- BULLET (U+2022, UTF-8: E2 80 A2)
    space = ' ',
    eol = '↴',
}
opt.fillchars = {
    eob = '↴', -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
    -- vert = '│', -- window border when window splits vertically ─ ┴ ┬ ┤ ├ ┼
    vert = "\\", -- window border when window splits vertically ─ ┴ ┬ ┤ ├ ┼
}

-- opt.grepformat = "%f:%l:%c:%m"
opt.grepprg="rg --vimgrep"
-- opt.grepformat:prepend{"%f:%l:%c:%m"}

-- vim.opt.winbar = '%#WinBarFileName#%f%* %M%='
opt.cmdheight = 1

opt.undofile = true
local undoPath = vim.fn.stdpath('data') .. '/.UndoDir'
opt.undodir=undoPath
if vim.fn.isdirectory(undoPath) == 0 then
    vim.fn.mkdir(vim.o.undodir, "p")
    -- vim.fn.system {
    --     'mkdir',
    --     '-p',
    --     undoPath
    -- }
end

-- Set in lua/treesitter/settings.lua
-- opt.foldmethod='syntax'
-- opt.foldlevelstart=99

opt.pastetoggle='<leader>pp'

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
-- vim.cmd[[set sessionoptions+=winpos,terminal,folds]]

opt.viewoptions="cursor,folds,slash,unix"
local viewPath = vim.fn.stdpath('data') .. '/.ViewDir'
opt.viewdir=viewPath
if vim.fn.isdirectory(viewPath) == 0 then
    vim.fn.mkdir(vim.o.viewdir, "p")
    -- vim.fn.system {
    --     'mkdir',
    --     '-p',
    --     viewPath
    -- }
end

local disable_distribution_plugins = function()
    vim.g.loaded_2html_plugin = 1
    vim.g.loaded_getscript = 1
    vim.g.loaded_getscriptPlugin = 1
    vim.g.loaded_gzip = 1
    vim.g.loaded_logiPat = 1
    vim.g.loaded_man = 1
    vim.g.loaded_matchit = 1
    vim.g.loaded_matchparen = 1
    vim.g.loaded_remote_plugins = 1
    vim.g.loaded_rplugin = 1
    vim.g.loaded_rrhelper = 1
    vim.g.loaded_shada_plugin = 1
    vim.g.loaded_shada_plugin = 1
    vim.g.loaded_spec = 1
    vim.g.loaded_spellfile_plugin = 1
    vim.g.loaded_spellfile_plugin = 1
    vim.g.loaded_tar = 1
    vim.g.loaded_tarPlugin = 1
    vim.g.loaded_tutor_mode_plugin = 1
    vim.g.loaded_vimball = 1
    vim.g.loaded_vimballPlugin = 1
    vim.g.loaded_zip = 1
    vim.g.loaded_zipPlugin = 1

    vim.g.load_black = 1
    vim.g.loaded_fzf = 1
    vim.g.loaded_gtags = 1
    vim.g.loaded_gtags_cscope = 1

    -- vim.g.loaded_node_provider = 0
    -- vim.g.loaded_perl_provider = 0
    -- vim.g.loaded_python3_provider = 0
    -- vim.g.loaded_python_provider = 0
    -- vim.g.loaded_pythonx_provider = 0
    -- vim.g.loaded_ruby_provider = 0

    vim.g.loaded_netrwFileHandlers = 1
    vim.g.loaded_netrwPlugin = 1
    vim.g.loaded_netrwSettings = 1
end
disable_distribution_plugins()

-- We do this to prevent the loading of the system fzf.vim plugin. This is
-- present at least on Arch/Manjaro/Void
vim.opt.runtimepath:remove("/etc/xdg/nvim")
vim.opt.runtimepath:remove("/etc/xdg/nvim/after")
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")
-- vim.cmd[[set rtp-=/usr/share/vim/vimfiles]]
