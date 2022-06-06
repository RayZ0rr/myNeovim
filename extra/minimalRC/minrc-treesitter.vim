if has('vim_starting')
  set encoding=utf-8
endif
scriptencoding utf-8

if &compatible
  set nocompatible
endif

let s:plug_dir = expand('/tmp/plugged/vim-plug')
if !filereadable(s:plug_dir .. '/plug.vim')
  execute printf('!curl -fLo %s/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim', s:plug_dir)
end

execute 'set runtimepath+=' . s:plug_dir
call plug#begin(s:plug_dir)

Plug 'nvim-treesitter/nvim-treesitter'

call plug#end()
PlugInstall | quit

lua << EOF

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

EOF
