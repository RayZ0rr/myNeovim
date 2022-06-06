local on_windows = vim.loop.os_uname().version:match 'Windows'

local function join_paths(...)
  local path_sep = on_windows and '\\' or '/'
  local result = table.concat({ ... }, path_sep)
  return result
end

vim.cmd [[set runtimepath=$VIMRUNTIME]]

--vim.cmd [[ source ~/minimal_settings.vim ]]
local temp_dir
if on_windows then
  temp_dir = vim.loop.os_getenv 'TEMP'
else
  temp_dir = '/tmp'
end

vim.cmd('set packpath=' .. join_paths(temp_dir, 'nvim', 'site'))

local package_root = join_paths(temp_dir, 'nvim', 'site', 'pack')
local install_path = join_paths(package_root, 'packer', 'start', 'packer.nvim')
local compile_path = join_paths(install_path, 'plugin', 'packer_compiled.lua')

local function load_plugins()
  require('packer').startup {
    {
      'wbthomason/packer.nvim',
      'nvim-treesitter/nvim-treesitter',
			-- 'nvim-treesitter/nvim-treesitter-textobjects',
			-- 'JoosepAlviste/nvim-ts-context-commentstring',
      -- 'neovim/nvim-lspconfig',
			-- 'navarasu/onedark.nvim',
    },
    config = {
      package_root = package_root,
      compile_path = compile_path,
    },
  }
end

if vim.fn.isdirectory(install_path) == 0 then
  vim.fn.system { 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path }
  load_plugins()
  require('packer').sync()
  vim.cmd [[autocmd User PackerComplete ++once lua load_config()]]
else
  load_plugins()
  require('packer').sync()
end

-- vim.cmd [[ source $HOME/.config/nvim/vimscript/options/settings.vim ]]
-- vim.cmd [[ luafile $HOME/.config/nvim/lua/options/mappings.lua]]
-- vim.cmd [[ source $HOME/.config/nvim/vimscript/options/themes.vim ]]
-- vim.cmd [[luafile $HOME/.config/nvim/lua/plugins/treesitter/init.lua]]

-- vim.opt.syntax = 'enable'
vim.cmd [[ syntax enable ]]
-- Treesitter configuration

vim.cmd([[
 	set foldmethod=expr
	set foldexpr=nvim_treesitter#foldexpr()
	set foldlevel=99
]])

-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"lua",
		"python",
		"rust",
		"html",
		"css",
		"toml",
		"vim",
		-- for `nvim-treesitter/playground`
		"query",
	},
	-- Install languages synchronously (only applied to `ensure_installed`)
	sync_install = false,
	highlight = {
		enable = true, -- false will disable the whole extension
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			-- init_selection = 'gnn',
			init_selection = '<cr>',
			node_incremental = '<tab>',
			scope_incremental = 'grc',
			node_decremental = '<s-tab>',
		},
  },
  indent = {
    enable = true,
  },
}
