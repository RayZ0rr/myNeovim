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
vim.opt.cmdheight = 1

opt.undofile = true
local undoPath = vim.fn.stdpath('data') .. '/.UndoDir'
if vim.fn.isdirectory(undoPath) == 0 then
  vim.fn.system {
    'mkdir',
    '-p',
    undoPath
  }
end
opt.undodir=undoPath

-- Set in lua/treesitter/settings.lua
-- opt.foldmethod='syntax'
-- opt.foldlevelstart=99

-- We do this to prevent the loading of the system fzf.vim plugin. This is
-- present at least on Arch/Manjaro/Void
vim.cmd[[set rtp-=/usr/share/vim/vimfiles]]

opt.pastetoggle='<leader>pp'

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
-- vim.cmd[[set sessionoptions+=winpos,terminal,folds]]

opt.viewoptions="cursor,folds,slash,unix"
local viewPath = vim.fn.stdpath('data') .. '/.ViewDir'
if vim.fn.isdirectory(viewPath) == 0 then
  vim.fn.system {
    'mkdir',
    '-p',
    viewPath
  }
end
opt.viewdir=viewPath

-- local disable_distribution_plugins = function()
--   g.did_load_fzf = 1
--   g.did_load_gtags = 1
--   g.did_load_gzip = 1
--   g.did_load_tar = 1
--   g.did_load_tarPlugin = 1
--   g.did_load_zip = 1
--   g.did_load_zipPlugin = 1
--   g.did_load_getscript = 1
--   g.did_load_getscriptPlugin = 1
--   g.did_load_vimball = 1
--   g.did_load_vimballPlugin = 1
--   g.did_load_matchit = 1
--   g.did_load_matchparen = 1
--   g.did_load_2html_plugin = 1
--   g.did_load_logiPat = 1
--   g.did_load_rrhelper = 1
--   g.did_load_netrw = 1
--   g.did_load_netrwPlugin = 1
--   g.did_load_netrwSettings = 1
--   g.did_load_netrwFileHandlers = 1
-- end
-- disable_distribution_plugins()

local disabled_built_ins = {
  "fzf",
  "gzip",
  "tar",
  "tarPlugin",
  "zip",
  "zipPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "matchit",
  "matchparen",
  "rrhelper",
  "tohmtl",
  "2html_plugin",
  "logipat",
  -- "netrw",
  -- "netrwPlugin",
  -- "netrwSettings",
  -- "netrwFileHandlers",
}
for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

-- local fn = vim.fn

-- function _G.qftf(info)
--     local items
--     local ret = {}
--     -- The name of item in list is based on the directory of quickfix window.
--     -- Change the directory for quickfix window make the name of item shorter.
--     -- It's a good opportunity to change current directory in quickfixtextfunc :)
--     --
--     -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
--     -- local root = getRootByAlterBufnr(alterBufnr)
--     -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
--     --
--     if info.quickfix == 1 then
--         items = fn.getqflist({id = info.id, items = 0}).items
--     else
--         items = fn.getloclist(info.winid, {id = info.id, items = 0}).items
--     end
--     local limit = 31
--     local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
--     local validFmt = '%s │%5d:%-3d│%s %s'
--     for i = info.start_idx, info.end_idx do
--         local e = items[i]
--         local fname = ''
--         local str
--         if e.valid == 1 then
--             if e.bufnr > 0 then
--                 fname = fn.bufname(e.bufnr)
--                 if fname == '' then
--                     fname = '[No Name]'
--                 else
--                     fname = fname:gsub('^' .. vim.env.HOME, '~')
--                 end
--                 -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
--                 if #fname <= limit then
--                     fname = fnameFmt1:format(fname)
--                 else
--                     fname = fnameFmt2:format(fname:sub(1 - limit))
--                 end
--             end
--             local lnum = e.lnum > 99999 and -1 or e.lnum
--             local col = e.col > 999 and -1 or e.col
--             local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
--             str = validFmt:format(fname, lnum, col, qtype, e.text)
--         else
--             str = e.text
--         end
--         table.insert(ret, str)
--     end
--     return ret
-- end

-- vim.o.qftf = '{info -> v:lua._G.qftf(info)}'
