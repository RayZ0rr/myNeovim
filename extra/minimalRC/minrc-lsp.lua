local on_windows = vim.loop.os_uname().version:match 'Windows'

local function join_paths(...)
  local path_sep = on_windows and '\\' or '/'
  local result = table.concat({ ... }, path_sep)
  return result
end

vim.cmd [[set runtimepath=$VIMRUNTIME]]

local temp_dir = vim.loop.os_getenv 'TEMP' or '/tmp'

vim.cmd('set packpath=' .. join_paths(temp_dir, 'nvim', 'site'))

local package_root = join_paths(temp_dir, 'nvim', 'site', 'pack')
local install_path = join_paths(package_root, 'packer', 'start', 'packer.nvim')
local compile_path = join_paths(install_path, 'plugin', 'packer_compiled.lua')

local function load_plugins()
  require('packer').startup {
    {
      'wbthomason/packer.nvim',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = {
      package_root = package_root,
      compile_path = compile_path,
    },
  }
end

_G.load_config = function()
  vim.cmd [[ syntax enable ]]
  vim.cmd([[ " PROBLEM PART
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
    set foldlevel=99
  ]])
  require('lspconfig').clangd.setup{}
  -- vim.cmd([[ " PUTTING HERE WORKS
    -- set foldmethod=expr
    -- set foldexpr=nvim_treesitter#foldexpr()
    -- set foldlevel=99
  -- ]])
end

if vim.fn.isdirectory(install_path) == 0 then
  vim.fn.system { 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path }
  load_plugins()
  require('packer').sync()
  vim.cmd [[autocmd User PackerComplete ++once lua load_config()]]
else
  load_plugins()
  require('packer').sync()
  _G.load_config()
end

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
