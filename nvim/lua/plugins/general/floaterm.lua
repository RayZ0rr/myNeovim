local nnmap = require('options/utils').nnmap
local tnmap = require('options/utils').tnmap

-- vim.api.nvim_set_hl(0,"FloatermBorder",{ fg = '#C3E88D', reverse = true }) -- diff mode: Added line

vim.g.floaterm_opener = 'edit'
vim.g.floaterm_borderchars = '        '
vim.g.floaterm_title = ''
vim.g.floaterm_autoclose = 1
vim.g.floaterm_width = 0.7
vim.g.floaterm_height = 0.7
nnmap('<leader>tr', '<cmd>FloatermToggle scratch<CR>' )
tnmap('<leader>tr', [[<cmd>FloatermToggle scratch<CR>]] )
nnmap('<leader>tt', [[<cmd>FloatermNew --name=Vifm --disposable vifm<CR>]])
tnmap('<leader>tt', [[<cmd>FloatermToggle Vifm<CR>]])
nnmap(']t', [[<cmd>FloatermNext<CR>]])
nnmap('[t', [[<cmd>FloatermPrev<CR>]])
nnmap('<leader>tg', '<cmd>FloatermNew --name=LazyGit lazygit<CR>' )
tnmap('<leader>tg', [[<cmd>FloatermToggle LazyGit<CR>]] )
-- vim.cmd[[autocmd User FloatermOpen nnoremap tt :FloatermToggle<CR>]]
