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
tnmap('<leader>tr', [[<C-\><C-n><cmd>FloatermToggle scratch<CR>]] )
nnmap('<leader>tt', [[<cmd>FloatermNew --name=Vifm vifm<CR>]])
tnmap('<leader>tt', [[<C-\><C-n><cmd>FloatermToggle Vifm<CR>]])
-- nnmap('<leader>tf', [[:execute 'FloatermToggle --name=Vifm vifm' fnameescape(getcwd())<CR>]])
-- tnmap('<leader>tf', [[<C-\><C-n><cmd>execute 'FloatermToggle --name=Vifm vifm' fnameescape(getcwd())<CR>]])
-- vim.api.nvim_set_keymap('t','<leader>tt', [[<C-\><C-n>:execute 'FloatermToggle Vifm'<CR>]], {remap = false, silent = false})
-- vim.cmd[[autocmd User FloatermOpen nnoremap tt :FloatermToggle<CR>]]
-- vim.api.nvim_set_keymap('t','<leader>tt', [[<C-\><C-n>:execute 'FloatermToggle vifm'<CR>]], {remap = false, silent = true})
-- vim.api.nvim_set_keymap('t','<leader>tr', [[<C-\><C-n>:FloatermToggle<CR>]], {remap = false, silent = true})
