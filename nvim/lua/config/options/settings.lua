local opt = vim.opt
local vimg = vim.g

-- set leader key
vimg.mapleader = ","
vimg.maplocalleader="\\"

-- opt.whichwrap:append "<>[]hl"
opt.breakindent = true
opt.termguicolors = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.inccommand='nosplit'
opt.wrap = false                        -- Display long lines as just one line
opt.wildoptions:append("pum")
opt.wildmenu = true                   -- Enhanced command completion
opt.wildmode = "longest,list,full"
opt.pumblend = 10			-- Popup blend
opt.hidden = true                       -- Don't discard hidden buffers
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
opt.colorcolumn = "80"                  -- Draw a column at 80 character width
opt.scrolloff=4                         -- Keep 4 lines below cursor before scrolling the screen vertically
opt.sidescrolloff=8                     -- Keep 8 lines below cursor before scrolling the screen horizontally
opt.smartindent = true                  -- Makes indenting smart
opt.number = true                       -- Line numbers
opt.cursorline = false                   -- Enable highlighting of the current line
opt.showmatch = true                    -- " Highlight matching brace
opt.showtabline=1                       -- only if there are at least two tab pages
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
vimg.editorconfig_enable = true

opt.list = true
opt.listchars = {
    nbsp = '⦸', -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
    extends = '»', -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
    precedes = '«', -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
    -- tab = '▷─', -- '▷─' WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
    tab = '▸-',
    trail = '•', -- BULLET (U+2022, UTF-8: E2 80 A2)
    -- space = ' ',
    -- eol = '↴',
}
opt.fillchars = {
    eob = '↴', -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
    -- vert = '│', -- window border when window splits vertically ─ ┴ ┬ ┤ ├ ┼
    vert = "\\", -- window border when window splits vertically ─ ┴ ┬ ┤ ├ ┼
}

if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --no-heading --smart-case --hidden"
  opt.grepformat = "%f:%l:%c:%m"
end
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

-- opt.pastetoggle='<leader>pp'

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
    vimg.loaded_2html_plugin = 1
    vimg.loaded_getscript = 1
    vimg.loaded_getscriptPlugin = 1
    vimg.loaded_gzip = 1
    vimg.loaded_logiPat = 1
    -- vimg.loaded_man = 0
    vimg.loaded_matchit = 1
    vimg.loaded_matchparen = 1
    vimg.loaded_remote_plugins = 1
    vimg.loaded_rplugin = 1
    vimg.loaded_rrhelper = 1
    vimg.loaded_shada_plugin = 1
    vimg.loaded_spec = 1
    vimg.loaded_spellfile_plugin = 1
    vimg.loaded_tar = 1
    vimg.loaded_tarPlugin = 1
    vimg.loaded_tutor_mode_plugin = 1
    vimg.loaded_vimball = 1
    vimg.loaded_vimballPlugin = 1
    vimg.loaded_zip = 1
    vimg.loaded_zipPlugin = 1
    vimg.loaded_sql_completion = 1

    vimg.load_black = 1
    vimg.loaded_fzf = 1
    vimg.loaded_gtags = 1
    vimg.loaded_gtags_cscope = 1

    vimg.loaded_python3_provider = 0
    vimg.loaded_python_provider = 0
    vimg.loaded_pythonx_provider = 0
    vimg.loaded_ruby_provider = 0
    vimg.loaded_node_provider = 0
    vimg.loaded_perl_provider = 0

    -- vimg.loaded_netrwFileHandlers = 1
    -- vimg.loaded_netrwPlugin = 1
    -- vimg.loaded_netrwSettings = 1
end
disable_distribution_plugins()

-- We do this to prevent the loading of the system fzf.vim plugin. This is
-- present at least on Arch/Manjaro/Void
vim.opt.runtimepath:remove("/etc/xdg/nvim")
vim.opt.runtimepath:remove("/etc/xdg/nvim/after")
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")
-- vim.cmd[[set rtp-=/usr/share/vim/vimfiles]]
