-- ##########################################
--  GENERAL SETTINGS
-- ##########################################

-- ------------------------------------------
--  Options
-- ------------------------------------------
require('options/settings') -- General options
require('options/mappings') -- General Mappings
require('options/myAutos') -- General autogroups and autocommands

-- ------------------------------------------
-- Custom Commands & Functions
-- ------------------------------------------
vim.cmd[[
source $HOME/.config/nvim/vimscript/options/myCmdsAndFns.vim
]]

-- ##########################################
--  PLUGINS SETTINGS
-- ##########################################

-- ------------------------------------------
--  Install
-- ------------------------------------------

-- Paq -----------------------------------
require('plugins/options/pluginsConfig')

-- ------------------------------------------
--  Config
-- ------------------------------------------

-- Now configured in '~/.config/nvim/lua/plugins/options/pluginsConfig.lua' file
