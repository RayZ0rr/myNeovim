"##########################################
" GENERAL SETTINGS
"##########################################

"------------------------------------------
" Options
"------------------------------------------
lua require('options/settings')
" source $HOME/.config/nvim/vimscript/options/settings.vim

"------------------------------------------
" Mappings
"------------------------------------------
lua require('options/mappings')
" source $HOME/.config/nvim/vimscript/options/mappings.vim

"------------------------------------------
"Custom AutoGroups, Commands & Functions
"------------------------------------------
source $HOME/.config/nvim/vimscript/options/myCmdsAndFns.vim
source $HOME/.config/nvim/vimscript/options/myAutos.vim

"##########################################
" PLUGINS SETTINGS
"##########################################

"------------------------------------------
" Install
"------------------------------------------

" Vim-Plug -----------------------------------
"source $HOME/.config/nvim/vimscript/plugins/options/pluginsList.vim

" Packer -----------------------------------
lua require('plugins/options/pluginsConfig')
" lua require('plugins/options/pluginsList')

"------------------------------------------
" Config
"------------------------------------------

" Now configured in '~/.config/nvim/lua/plugins/options/pluginsList' file
" -----------------------------------------------------------------------
" lua require('plugins/options/setup')
" source $HOME/.config/nvim/vimscript/plugins/options/setup.vim

" Extra plugin config --------------------------------------------------
" source $HOME/.config/nvim/vimscript/plugins/general/undotree.vim
" source $HOME/.config/nvim/vimscript/plugins/general/fastfold.vim
" lua require('plugins/general/misc')
