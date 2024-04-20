-- ##########################################
--  GENERAL SETTINGS
-- ##########################################

-- ------------------------------------------
--  Options
-- ------------------------------------------
require 'config/options/settings'
require 'config/options/keymaps'
require 'config/options/myAutos' -- Autogroups and Autocommands

-- ------------------------------------------
-- Custom Commands & Functions
-- ------------------------------------------
vim.cmd[[
source $HOME/.config/nvim/vimscript/options/myCmdsAndFns.vim
]]

-- ##########################################
--  PLUGINS SETTINGS
-- ##########################################
require 'config/plugins/bootstrap' -- Load plugin manager
require 'config/plugins/pluginsList' -- Install/Load plugins
