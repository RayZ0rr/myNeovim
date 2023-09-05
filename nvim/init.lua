-- ##########################################
--  GENERAL SETTINGS
-- ##########################################

-- ------------------------------------------
--  Options
-- ------------------------------------------
require('config/options/settings') -- General options
require('config/options/keymaps') -- General Mappings
require('config/options/myAutos') -- General autogroups and autocommands

-- ------------------------------------------
-- Custom Commands & Functions
-- ------------------------------------------
vim.cmd[[
source $HOME/.config/nvim/vimscript/options/myCmdsAndFns.vim
]]

-- ##########################################
--  PLUGINS SETTINGS
-- ##########################################

require('config/plugins/options/pluginsList')
