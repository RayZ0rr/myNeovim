-- don't throw any error on first use by packer
local ok, packer = pcall(require, "packer")
if not ok then return end

local packer_bootstrap = require('plugins/options/bootstrap').packer_bootstrap
-- ########################################################
-- All the used plugins
-- ########################################################

-- return packer.startup({
--   function(use)
packer.startup(function(use)

  -- Package manager ---------------------------
  use 'wbthomason/packer.nvim'

  --------------------------------------------------
  -- Utilities
  --------------------------------------------------

  use 'lewis6991/impatient.nvim'

  -- FZF ----------------------------------------
  use {
    'ibhagwan/fzf-lua',
    requires = {
      'kyazdani42/nvim-web-devicons'
    }, -- optional for icons
    config = function()
      require('plugins/general/fzf-lua')
    end,
    -- config = [[ require('plugins/general/fzf-lua') ]]
  }
  -- Better quickfix --------------------------
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
    'skywind3000/asyncrun.vim',
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
  -- use {
  --   'is0n/fm-nvim',
  --   config = function()
  --     require('plugins/general/fm-nvim')
  --   end,
  -- }
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
  -- Faster Folding ------------------------------
  use {
    'Konfekt/FastFold',
    config = function()
      require('plugins/general/misc')
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
  -- Material Theme -----------------------------
  -- use {
  --   'marko-cerovac/material.nvim',
  --   config = function()
  --     require('plugins/themes/material')
  --   end,
  -- }

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
    'feline-nvim/feline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('plugins/general/feline')
    end,
    -- Enable for default status bar
    -- config = function()
    --     require('feline').setup()
    -- end
  }
  -- StartScreen -----------------------------------
  use {
    'goolord/alpha-nvim',
    config = function()
      require('plugins/general/alpha')
    end,
  }
  -- Tab/buffers display and customize -----------
  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('plugins/general/bufferline')
    end,
  }
  -- Startup time measure --------------------------
  use 'dstein64/vim-startuptime'
  -- Align code for eg, arround '=' sign ---------
  use {
    'junegunn/vim-easy-align',
    config = function()
      require('plugins/general/misc')
    end,
  }
  -- Add git related info in the signs columns and popups
  use {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
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
  -- Improve the default UI hooks (vim.ui.select and vim.ui.input)
  -- use {
  --   'stevearc/dressing.nvim',
  --   config = function()
  --     require('plugins/general/dressing')
  --   end,
  -- }
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

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end

end)
