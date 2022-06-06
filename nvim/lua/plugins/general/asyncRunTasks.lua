vim.api.nvim_set_keymap( 'n','<leader><F7>', [[<cmd>AsyncRun clang++ -std=c++17 -Wall -Wextra -pedantic -Weffc++ -Wsign-conversion "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"<cr>]],{noremap=true} )
vim.api.nvim_set_keymap( 'n','<leader><F9>', [[:AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>]],{noremap=true} )
vim.api.nvim_set_keymap( 'n','<leader><F10>', [[:call asyncrun#quickfix_toggle(6)<cr>]],{noremap=true} )

vim.g.asyncrun_rootmarks = {'.svn', '.git', '.root', '_darcs', 'build.xml'}
vim.g.asyncrun_open = 6
vim.g.asyncrun_bell = 1

