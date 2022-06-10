local ok, impatient = pcall(require, 'impatient')
if ok then
  impatient.enable_profile()
else
  vim.notify("impatient not installed")
end

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

-- Packer -----------------------------------
require('plugins/options/bootstrap')

-- ------------------------------------------
--  Config
-- ------------------------------------------
require('plugins/options/pluginsList')
