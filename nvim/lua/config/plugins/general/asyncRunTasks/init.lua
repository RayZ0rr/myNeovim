local map = require('config/options/utils').map
local nnmap = require('config/options/utils').nnmap

nnmap( '<leader><F9>', [[<cmd>AsyncRun clang++ -std=c++17 -Wall -Wextra -pedantic -Weffc++ -Wsign-conversion "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT).exe"<cr>]], {desc="AsyncRun build"} )
nnmap( '<leader><F10>', [[:AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT).exe" <cr>]], {desc="AsyncRun run"} )

vim.g.asyncrun_rootmarks = {'.svn', '.git', '.root', 'Makefile', 'compile_flags.txt', 'compile_commands.json', '.project', '_darcs', 'build.xml'}
vim.g.asyncrun_open = 6
vim.g.asyncrun_bell = 1
vim.g.asyncrun_mode = 'term'

nnmap( '<leader><F5>', [[<cmd>AsyncTask build<cr>]], {desc="AsyncTask build"} )
nnmap( '<leader><F6>', [[<cmd>AsyncTask run<cr>]], {desc="AsyncTask run"} )

vim.g.asynctasks_extra_config = {
    '~/.config/nvim/lua/config/plugins/general/asyncRunTasks/tasks.ini',
    }
