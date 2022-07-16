-- don't throw any error on first use by packer
local ok, packer = pcall(require, "packer")
if not ok then return end

-- ########################################################
-- All the used plugins
-- ########################################################

-- return packer.startup({
--   function(use)
packer.startup(function(use)

  -- Package manager ---------------------------
  use 'wbthomason/packer.nvim'

  use 'lewis6991/impatient.nvim'

  --------------------------------------------------
  -- GENERAL
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
    'is0n/fm-nvim',
    config = function()
      require('plugins/general/fm-nvim')
    end,
  }
  -- use {
  --   'voldikss/vim-floaterm',
  --   config = function()
  --     require('plugins/general/floaterm')
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
    -- 'rmagatti/auto-session',
    'Shatur/neovim-session-manager',
    config = function()
      require('plugins/general/sessions')
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
  -- use 'marko-cerovac/material.nvim'
  -- use 'navarasu/onedark.nvim' -- Onedark colorscheme with lsp support
  -- use 'sainnhe/sonokai' -- Monokai colorscheme with lsp support
  -- use 'joshdick/onedark.vim' -- Onedark

  -- use 'RRethy/nvim-base16' -- Colorscheme list
  -- use 'folke/lsp-colors.nvim' -- Add lsp highlights to colorscheme without it

  -- use 'morhetz/gruvbox' -- Gruvbox

  -- -----------------------------------------------
  -- UI/LOOK
  -- -----------------------------------------------

  -- Startup time measure --------------------------
  use 'dstein64/vim-startuptime'
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
    -- config = function ()
    --     require'alpha'.setup(require'alpha.themes.dashboard'.opts)
    -- end
  }
  -- Tab/buffers display and customize -----------
  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('plugins/general/bufferline')
    end,
  }
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
  -- Spell check helper plugin ---------------------
  use {
    'kamykn/spelunker.vim',
    requires = 'kamykn/popup-menu.nvim',
    config = function()
      require('plugins/general/spelunker')
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
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('plugins/general/misc')
    end,
  }
  -- Highlight cursorline during jump ---------------
  use {
    -- 'danilamihailov/beacon.nvim'
    'edluffy/specs.nvim',
    config = function()
      require('plugins/general/misc')
    end,
  }
  -- Improve the default UI hooks (vim.ui.select and vim.ui.input)
  use {
    'stevearc/dressing.nvim',
    config = function()
      require('plugins/general/dressing')
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
  use "tversteeg/registers.nvim"
  -- use { -- Add indentation guides even on blank lines
  --   'lukas-reineke/indent-blankline.nvim',
  --   config = [[ require('plugins/general/indent-blankline') ]],
  -- }

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
  -- File Browser ------------------------------
  use {
    'stevearc/aerial.nvim',
    config = function()
      require('plugins/LSP/utils/aerial')
    end,
  }
  -- Higlight occurances of word under cursor
  use {
    'RRethy/vim-illuminate',
    config = function()
      require('plugins/general/misc')
    end,
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
  -- use  { -- Lsp better functioning.
  --  'RishabhRD/nvim-lsputils',
  --  requires = {'RishabhRD/popfix'}
  -- }

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

end)
