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
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/vim-vsnip'
Plug 'neovim/nvim-lspconfig'
call plug#end()
PlugInstall | quit

source $HOME/.config/nvim/vimscript/options/settings.vim
luafile $HOME/.config/nvim/lua/options/mappings.lua

" Setup global configuration. More on configuration below.
lua << EOF
local cmp = require "cmp"
cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },

  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true })
  },

  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
  },
}
EOF

lua << EOF
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local server_config = {
	capabilities = capabilities;
	flags = {
		debounce_text_changes = 150,
	}
}

require'lspconfig'.clangd.setup {
	server_config,
	cmd = { 
		"clangd",  
		"--background-index",
	},
}
EOF
