-- General ---------------------------------

require('plugins/general/fzf-lua')
require('plugins/general/nvim-cmp')
vim.cmd[[source $HOME/.config/nvim/vimscript/plugins/general/undotree.vim]]
require('plugins/general/nvim-autopairs')
require('plugins/general/kommentary')
vim.cmd[[source $HOME/.config/nvim/vimscript/plugins/general/fastfold.vim]]
require('plugins/general/spelunker')
require('plugins/general/fm-nvim')
require('plugins/general/auto-session')
require('plugins/general/misc')
-- vim.cmd[[ source $HOME/.config/nvim/vimscript/plugins/fzf.vim]]
-- vim.cmd[[ source $HOME/.config/nvim/vimscript/plugins/misc.vim]]
-- require('plugins/general/nvim-tree')
-- require('plugins/general/nv-vsnip')

-- UI/Look -----------------------------------

require('plugins/general/feline')
require('plugins/general/alpha')
require('plugins/general/nvim-bufferline')
require('plugins/general/indent-blankline')
require('plugins/general/whitespace')
require('plugins/general/vim-matchup')
require('plugins/general/marks')
-- vim.cmd[[source $HOME/.config/nvim/vimscript/plugins/startify.vim]]
-- require('plugins/general/galaxyline/disrupted')
-- vim.cmd[[source $HOME/.config/nvim/vimscript/plugins/fernTree.vim]]
-- vim.cmd[[source $HOME/.config/nvim/vimscript/plugins/airline.vim]]
-- vim.cmd[[source $HOME/.config/nvim/vimscript/keys/nerdTree.vim]]
-- vim.cmd[[source $HOME/.config/nvim/vimscript/plugins/nvimTree.vim]]
-- vim.cmd[[source $HOME/.config/nvim/vimscript/keys/CHADtree.vim]]

-- LSP -----------------------------------

require('plugins/LSP/settings')
require('plugins/LSP/lsp_signature')
require('plugins/LSP/nvim-lightbulb')
require('plugins/LSP/aerial')
-- require('plugins/LSP/lsp-utils')
-- vim.cmd[[source $HOME/.config/nvim/vimscript/plugins/LSP/lsp-config.vim]]
-- vim.cmd[[source $HOME/.config/nvim/vimscript/plugins/snippets.vim]]

-- Treesitter -----------------------------

--require('plugins/treesitter')
