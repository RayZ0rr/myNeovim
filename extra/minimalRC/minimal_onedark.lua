-- ignore default config and plugins
vim.opt.runtimepath:remove(vim.fn.expand("~/.config/nvim"))
vim.opt.packpath:remove(vim.fn.expand("~/.local/share/nvim/site"))

-- append test directory
local test_dir = "/tmp/onedarkpro"
vim.opt.runtimepath:append(vim.fn.expand(test_dir))
vim.opt.packpath:append(vim.fn.expand(test_dir))

-- install packer
local install_path = test_dir .. "/pack/packer/start/packer.nvim"
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    vim.cmd("packadd packer.nvim")
    install_plugins = true
end

local packer = require("packer")

packer.init({
    package_root = test_dir .. "/pack",
    compile_path = test_dir .. "/plugin/packer_compiled.lua",
})

-- install plugins
packer.startup(function(use)
    use("wbthomason/packer.nvim")
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("olimorris/onedarkpro.nvim")
    use {
      'feline-nvim/feline.nvim',
      requires = 'kyazdani42/nvim-web-devicons',
      -- Enable for default status bar
      config = function()
          require('feline').setup()
      end
     }
--   use {
--     'ibhagwan/fzf-lua',
--     requires = {
--       'kyazdani42/nvim-web-devicons'
--     }, -- optional for icons
--   }
-- use {
--   'akinsho/bufferline.nvim',
--   requires = 'kyazdani42/nvim-web-devicons',
--   config = function()
--       require('bufferline').setup()
--   end
-- }

    -- Add any additional plugins here

    if install_plugins then
        packer.sync()
    end
end)

-- setup treesitter
local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if ok then
    treesitter.setup({
        ensure_installed = "all",
        ignore_install = { "phpdoc" }, -- list of parser which cause issues or crashes
        highlight = { enable = true },
    })
end

-- setup onedarkpro
local ok, onedarkpro = pcall(require, "onedarkpro")
if ok then
    onedarkpro.setup({
      -- Your onedarkpro config here
    })
    vim.cmd("colorscheme onedarkpro")
end
