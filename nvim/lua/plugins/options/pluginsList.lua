local packer_bootstrap = require('plugins/options/bootstrap').packer_bootstrap
-- ########################################################
-- All the used plugins
-- ########################################################

-- return packer.startup({
--   function(use)
require('packer').startup(function(use)

  -- Package manager ---------------------------
  use 'wbthomason/packer.nvim'

  use 'lewis6991/impatient.nvim'

  --------------------------------------------------
  -- LSP
  --------------------------------------------------

  -- Collection of configurations for built-in LSP client
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require('plugins/LSP')
    end,
  }
  -- Symbol Browser ------------------------------
  use {
    'stevearc/aerial.nvim',
    config = function()
      require('plugins/LSP/utils/aerial')
    end,
  }

  --------------------------------------------------
  -- Treesitter
  --------------------------------------------------

  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('plugins/treesitter/settings')
    end,
  }
  use {
    'nvim-treesitter/playground',
    config = function()
      require "nvim-treesitter.configs".setup {
	playground = {
	  enable = true,
	}
      }
    end,
  }
  -- Additional textobjects for treesitter
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    requires = {'nvim-treesitter/nvim-treesitter'}
  }
  -- Context aware commenting using treesitter
  use {
    'JoosepAlviste/nvim-ts-context-commentstring',
    requires = {'nvim-treesitter/nvim-treesitter'}
  }

  ----------------------------------------------
  -- THEMES
  ----------------------------------------------

  -- Onedark Theme -----------------------------
  use {
    'olimorris/onedarkpro.nvim',
    config = function()
      require('plugins/themes/onedarkpro')
    end,
  }

  --------------------------------------------------
  -- Utilities
  --------------------------------------------------

  -- FZF ----------------------------------------
  use {
    'ibhagwan/fzf-lua',
    requires = {
      'kyazdani42/nvim-web-devicons'
    }, -- optional for icons
    config = function()
      require('plugins/general/fzf-lua')
    end,
  }
  -- Better quickfix --------------------------
  use {'kevinhwang91/nvim-bqf', ft = 'qf'}
  use {
    'gabrielpoca/replacer.nvim',
    config = function()
      require('plugins/general/misc')
    end,
  }
  -- Undo history ------------------------------
  use {
    'mbbill/undotree',
    config = function()
      require('plugins/general/misc')
    end,
  }
  -- Build, Run tasks (commands) in background asynchronously
  use{
    'skywind3000/asynctasks.vim',
    requires = {
      'skywind3000/asyncrun.vim',
    },
    config = function()
      require('plugins/general/asyncRunTasks')
    end,
  }
  -- Terminal conveniences plugin (filebrowser with vifm, lazygit etc)
  use {
    'voldikss/vim-floaterm',
    config = function()
      require('plugins/general/floaterm')
    end,
  }
  -- Autocompletion plugin ---------------------
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    config = function()
      require('plugins/general/nvim-cmp')
    end,
  }
  -- Snippets plugin ----------------------------
  use {
    "L3MON4D3/LuaSnip",
    requires = { "rafamadriz/friendly-snippets" },
  }
  -- Surround with characters -------------------
  use {
    "tpope/vim-surround",
  }
  -- Auto-pair completion -----------------------
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('plugins/general/nvim-autopairs')
    end,
  }
  -- Trailing whitspaces higlight and trim ------
  use {
    'ntpeters/vim-better-whitespace',
    config = function()
      require('plugins/general/misc')
    end,
  }
  -- Comment and Uncomment lines ----------------
  use {
    'b3nj5m1n/kommentary',
    config = function()
      require('plugins/general/kommentary')
    end,
  }
  -- Auto-session maker -------------------------
  use {
    'Shatur/neovim-session-manager',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('plugins/general/sessions')
    end,
  }
  -- Higlight occurances of word under cursor
  use {
    'RRethy/vim-illuminate',
    config = function()
      require('plugins/general/misc')
    end,
  }

  -- -----------------------------------------------
  -- UI/LOOK
  -- -----------------------------------------------

  -- Icon set ---------------------------------
  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('plugins/general/misc')
    end,
  }
  -- Statusline ------------------------------------
  use {
    'rebelot/heirline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('plugins/general/statusline/heirline')
    end,
    after = 'onedarkpro.nvim'
  }
  -- Add git related info in the signs columns and popups
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('plugins/general/misc')
    end,
  }
  -- StartScreen -----------------------------------
  use {
    'goolord/alpha-nvim',
    config = function()
      require('plugins/general/alpha')
    end,
  }
  -- Align code for eg, arround '=' sign ---------
  use {
    'Vonr/align.nvim',
    config = function()
      require('plugins/general/misc')
    end,
  }
  -- Highlight, navigate, and operate on sets of matching text
  use {
    'andymass/vim-matchup',
    config = function()
      require('plugins/general/vim-matchup')
    end,
  }
  -- Show colours around hex code ------------------
  use {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('plugins/general/misc')
    end,
  }
  -- Highlight cursorline during jump ---------------
  use {
    'edluffy/specs.nvim',
    config = function()
      require('plugins/general/misc')
    end,
  }
  -- Show marks and bookmarks -------------------
  use {
    'chentoast/marks.nvim',
    config = function()
      require('plugins/general/marks')
    end,
  }
  -- Registers in floating window and other convenience
  use {
    "tversteeg/registers.nvim",
    config = function()
      require("registers").setup()
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end

end)
