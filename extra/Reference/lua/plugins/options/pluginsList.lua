-- ########################################################
-- Bootstrap ( Check if "packer.nvim" exists or not )
-- ########################################################

-- If you want to automatically ensure that packer.nvim is installed on any machine you clone your configuration to,
-- add the following snippet (which is due to @Iron-E) somewhere in your config before your first usage of packer:
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
  -- vim.cmd 'packadd packer.nvim'
  -- print("Please exit NVIM and re-open, then run :PackerSync")
  -- return
end

-- don't throw any error on first use by packer
local ok, packer = pcall(require, "packer")
if not ok then return end

vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost pluginsList.lua source <afile> | echom "Updating and Recompiling plugins" | PackerSync
" autocmd BufWritePost **/pluginsList.lua lua packerSyncandSource()
" autocmd BufWritePost **/pluginsList.lua echo "Updating plugins" | :PackerSync | source $MYVIMRC
augroup end
]])

packer_config = {
  -- compile_path = vim.fn.stdpath("config") .. "/lua/plugins/options/packer_compiled.lua",
  profile = {
    enable = true,
    threshold = 1 -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
  display = {
    open_fn = require('packer.util').float,
    -- open_fn = function()
    --  return require('packer.util').float({ border = 'single' })
    -- end
  }
}

-- ########################################################
-- All the used plugins
-- ########################################################

local packer = require("packer")

packer.init(packer_config)

return packer.startup({

  function(use)

    -- Package manager ---------------------------
    use 'wbthomason/packer.nvim'

    ----------------------------------------------
    -- THEMES
    ----------------------------------------------

    -- use 'marko-cerovac/material.nvim'
    use {
      'olimorris/onedarkpro.nvim',
      config = [[ require('plugins/themes/onedarkpro') ]],
      -- config = [[ require('onedarkpro').load() ]],
    }
    -- use 'navarasu/onedark.nvim' -- Onedark colorscheme with lsp support
    -- use 'sainnhe/sonokai' -- Monokai colorscheme with lsp support
    -- use 'joshdick/onedark.vim' -- Onedark

    -- use 'RRethy/nvim-base16' -- Colorscheme list
    -- use 'folke/lsp-colors.nvim' -- Add lsp highlights to colorscheme without it

    -- use 'morhetz/gruvbox' -- Gruvbox

    -- --------------------------------------------
    -- GENERAL
    -- --------------------------------------------

    -- fzf ----------------------------------------
    -- use '~/.fzf'
    -- use = { 'junegunn/fzf', run = './install --bin', }
    -- use {'junegunn/fzf.vim'}
    use {
      'ibhagwan/fzf-lua',
      requires = {
        'vijaymarupudi/nvim-fzf',
        'kyazdani42/nvim-web-devicons'
      }, -- optional for icons
      config = [[ require('plugins/general/fzf-lua') ]]
    }

    use { -- Startup time measure
      'dstein64/vim-startuptime',
    }

    use { -- Undo history
      'mbbill/undotree',
      config = [[ require('plugins/general/undotree') ]]
      -- config = [[ vim.cmd(source $HOME/.config/nvim/vimscript/plugins/general/undotree.vim) ]]
    }

    -- File Browser ----------------------------------------
    use {
      'is0n/fm-nvim',
      config = [[ require('plugins/general/fm-nvim') ]]
    }
    -- use 'voldikss/vim-floaterm'
    -- use {
    --  'kyazdani42/nvim-tree.lua',
    --  requires = 'kyazdani42/nvim-web-devicons',
    -- config = function() require'nvim-tree'.setup {} end
    -- }

    -- use {
    --  'vifm/vifm.vim',
    --  requires = 'is0n/fm-nvim'
    -- }
    -- Fern tree viewer
    -- use 'lambdalisue/fern.vim'
    -- use 'lambdalisue/nerdfont.vim'
    -- use 'lambdalisue/fern-renderer-nerdfont.vim'

    use { -- Autocompletion plugin
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-buffer',
        -- 'hrsh7th/cmp-emoji',
        -- 'hrsh7th/cmp-calc',
        'hrsh7th/cmp-path',
        "hrsh7th/cmp-nvim-lua"
      },
      config = [[ require('plugins/general/nvim-cmp') ]]
    }

    use{  -- Snippets plugin
      "L3MON4D3/LuaSnip",
      requires = { "rafamadriz/friendly-snippets" },
      -- config = [[ require('plugins/general/luasnip') ]]
    }

    use{  -- Build, Run tasks (commands) in background asynchronously
      'skywind3000/asyncrun.vim',
      -- requires = { "rafamadriz/friendly-snippets" },
      config = [[ require('plugins/general/asyncRunTasks') ]]
    }

    use { -- Auto-pair completion
      'windwp/nvim-autopairs',
      config = [[ require('plugins/general/nvim-autopairs') ]]
    }

    use { -- Trailing whitspaces higlight and trim
      'ntpeters/vim-better-whitespace',
      config = [[ require('plugins/general/whitespace') ]]
    }

    use { -- Comment and Uncomment lines
      'b3nj5m1n/kommentary',
      config = [[ require('plugins/general/kommentary') ]]
    }

    use { -- Auto-session maker
      -- 'rmagatti/auto-session',
      'Shatur/neovim-session-manager',
      config = [[ require('plugins/general/auto-session') ]]
    }

    -- Better Syntax Support
    -- use 'sheerun/vim-polyglot'

    -- -----------------------------------------------
    -- UI/LOOK
    -- -----------------------------------------------

    use { -- Tab/buffers display and customize
      'akinsho/nvim-bufferline.lua',
      requires = 'kyazdani42/nvim-web-devicons',
      config = [[ require('plugins/general/nvim-bufferline') ]],
      -- config = function()
      -- require("bufferline").setup{}
      -- end
    }

    use { -- Show colours around hex code
      'norcalli/nvim-colorizer.lua',
    }
    use { -- Highlight cursorline after jumps
      -- 'danilamihailov/beacon.nvim'
      'edluffy/specs.nvim',
      config = [[ require('plugins/general/misc') ]],
    }
    -- Statusline ------------------------------------
    use {
      'feline-nvim/feline.nvim',
      requires = 'kyazdani42/nvim-web-devicons',
      config = [[ require('plugins/general/feline') ]],
      -- Enable for default status bar
      -- config = function()
      --     require('feline').setup()
      -- end
    }
    -- use {
    --  'glepnir/galaxyline.nvim',
    --  branch = 'main',
    -- }

    use { -- highlight, navigate, and operate on sets of matching text
      'andymass/vim-matchup',
      config = [[ require('plugins/general/vim-matchup') ]]
    }

    use { -- Improve the default UI hooks (vim.ui.select and vim.ui.input)
      'stevearc/dressing.nvim',
      config = [[ require('plugins/general/dressing') ]]
    }

    use { -- Spell check helper plugin
      'kamykn/spelunker.vim',
      requires = {'kamykn/popup-menu.nvim'},
      config = [[ require('plugins/general/spelunker') ]],
    }

    -- use { -- Add indentation guides even on blank lines
    --   'lukas-reineke/indent-blankline.nvim',
    --   config = [[ require('plugins/general/indent-blankline') ]],
    -- }

    use { -- Add git related info in the signs columns and popups
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('gitsigns').setup()
      end
    }

    -- StartScreen -----------------------------------
    use {
      'goolord/alpha-nvim',
      config = [[ require('plugins/general/alpha') ]],
      -- config = function ()
      --     require'alpha'.setup(require'alpha.themes.dashboard'.opts)
      -- end
    }
    -- use {
    --   "startup-nvim/startup.nvim",
    --   requires = {"nvim-lua/plenary.nvim"},
    --   -- config = [[ require('plugins/general/startup') ]],
    -- }

    -- Startify
    -- use 'mhinz/vim-startify'

    use { -- Show marks and bookmarks
      'chentau/marks.nvim',
      config = [[ require('plugins/general/marks') ]],
    }

    -- Registers in floating window and other convenience
    use "tversteeg/registers.nvim"

    --------------------------------------------------
    -- LSP
    --------------------------------------------------

    use { -- Collection of configurations for built-in LSP client
      'neovim/nvim-lspconfig',
      config = [[ require('plugins/LSP/settings') ]],
    }

    use {
      'stevearc/aerial.nvim',
      config = [[ require('plugins/LSP/utils/aerial') ]],
    }

    -- use({
    --  "jose-elias-alvarez/null-ls.nvim",
    -- config = function()
    --  require("null-ls").setup()
    -- end,
    --  requires = { "nvim-lua/plenary.nvim" },
    -- })

    -- use { -- Show lightbulb for diagnostics
    --   'kosayoda/nvim-lightbulb',
    --   config = [[ require('plugins/LSP/utils/nvim-lightbulb') ]],
    -- }

    -- use { -- Signature help plug
    --   'ray-x/lsp_signature.nvim',
    --   config = [[ require('plugins/LSP/utils/lsp_signature') ]],
    -- }

    use { -- Higlight occurances of word under cursor ------
      'RRethy/vim-illuminate',
      config = [[ require('plugins/general/misc') ]]
    }

    -- use  { -- Lsp better functioning.
    --  'RishabhRD/nvim-lsputils',
    --  requires = {'RishabhRD/popfix'}
    -- }

    --------------------------------------------------
    -- Treesitter
    --------------------------------------------------

    use { -- Highlight, edit, and navigate code using a fast incremental parsing library
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = [[ require('plugins/treesitter/settings') ]],
    }

    use { -- Additional textobjects for treesitter
      'nvim-treesitter/nvim-treesitter-textobjects',
      requires = {'nvim-treesitter/nvim-treesitter'}
    }

    use { -- Context aware commenting using treesitter
      'JoosepAlviste/nvim-ts-context-commentstring',
      requires = {'nvim-treesitter/nvim-treesitter'}
    }

    use { -- Faster Folding
      'Konfekt/FastFold',
      config = [[ require('plugins/general/misc') ]]
    }

    if packer_bootstrap then
      require('packer').sync()
    end

  end,
})
