local ok, lazy = pcall(require, "lazy")
if not ok then
  vim.cmd("echom '[Error] (pluginsList.lua): lazy.nvim not found. Skipping loading of plugins.'")
  return
end

-- ########################################################
-- All the used plugins
-- ########################################################

require('lazy').setup({

    ----------------------------------------------
    -- THEMES
    ----------------------------------------------

    -- Onedark Theme -----------------------------
    {
        'olimorris/onedarkpro.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('config/plugins/themes/onedarkpro')
        end,
    },
    -- {
    --     'RRethy/nvim-base16',
    --     config = function()
    --         require('config/theme_test')
    --     end
    -- },
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {style = "day",},
    --     config = function()
    --         require("tokyonight").setup({
    --           -- use the night style
    --           style = "day",
    --           -- disable italic for functions
    --           styles = {
    --             functions = {}
    --           },
    --           sidebars = { "qf", "vista_kind", "terminal", "packer" },
    --           -- Change the "hint" color to the "orange" color, and make the "error" color bright red
    --           on_colors = function(colors)
    --             colors.hint = colors.orange
    --             colors.error = "#ff0000"
    --           end
    --         })
    --         vim.o.background = "light"
    --         vim.cmd[[colorscheme tokyonight]]
    --     end,
    -- },

    -- Package manager ---------------------------
    { "folke/lazy.nvim", version = "*" },

    --------------------------------------------------
    -- LSP
    --------------------------------------------------

    -- Collection of configurations for built-in LSP client
    {
        'neovim/nvim-lspconfig',
        event = {"BufReadPost", "BufNewFile"},
        config = function()
            require('config/plugins/LSP')
        end,
    },
    -- Symbol Browser ------------------------------
    {
        'stevearc/aerial.nvim',
        config = function()
            require('config/plugins/LSP/utils/aerial')
        end,
    },

    --------------------------------------------------
    -- Treesitter
    --------------------------------------------------

    -- Highlight, edit, and navigate code using a fast incremental parsing library
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = {"BufReadPost", "BufNewFile"},
        config = function()
            require('config/plugins/treesitter/settings')
        end,
    },
    -- Additional textobjects for treesitter
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = {'nvim-treesitter/nvim-treesitter'}
    },
    -- Context aware commenting using treesitter
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        dependencies = {'nvim-treesitter/nvim-treesitter'}
    },

    --------------------------------------------------
    -- Utilities
    --------------------------------------------------

    -- FZF ----------------------------------------
    {
        'ibhagwan/fzf-lua',
        -- keys = { "<leader>f" },
        dependencies = {
            'kyazdani42/nvim-web-devicons'
        }, -- optional for icons
        config = function()
            require('config/plugins/general/fzf-lua')
        end,
    },
    -- Better quickfix --------------------------
    {'kevinhwang91/nvim-bqf', ft = 'qf'},
    -- Undo history ------------------------------
    {
        'mbbill/undotree',
        -- config = function()
        --     require('config/plugins/general/misc')
        -- end,
    },
    -- Build, Run tasks (commands) in background asynchronously
    {
        'skywind3000/asynctasks.vim',
        event = "BufWritePost",
        dependencies = {
            'skywind3000/asyncrun.vim',
            event = "BufWritePost",
        },
        config = function()
            require('config/plugins/general/asyncRunTasks')
        end,
    },
    -- Terminal conveniences plugin (filebrowser with vifm, lazygit etc)
    {
        'voldikss/vim-floaterm',
        -- keys = { "<leader>t" },
        config = function()
            require('config/plugins/general/floaterm')
        end,
    },
    -- Autocompletion plugin ---------------------
    {
        'hrsh7th/nvim-cmp',
        event = {"BufReadPost", "BufNewFile", "InsertEnter"},
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
        },
        config = function()
            require('config/plugins/general/nvim-cmp')
        end,
    },
    -- Snippets plugin ----------------------------
    {
        "L3MON4D3/LuaSnip",
        lazy = true,
        dependencies = { "rafamadriz/friendly-snippets" },
    },
    -- Surround with characters -------------------
    {
        "tpope/vim-surround",
    },
    -- Auto-pair completion -----------------------
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = function()
            require('config/plugins/general/nvim-autopairs')
        end,
    },
    -- Trailing whitspaces higlight and trim ------
    {
        'ntpeters/vim-better-whitespace',
        -- config = function()
        --     require('config/plugins/general/misc')
        -- end,
    },
    -- Comment and Uncomment lines ----------------
    {
        'b3nj5m1n/kommentary',
        init = function()
            vim.g.kommentary_create_default_mappings = false
        end,
        config = function()
            require('config/plugins/general/kommentary')
        end,
    },
    -- Auto-session maker -------------------------
    {
        'Shatur/neovim-session-manager',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            require('config/plugins/general/sessions')
        end,
    },
    -- Higlight occurances of word under cursor
    {
        'RRethy/vim-illuminate',
        event = {"BufReadPost", "BufNewFile"},
        -- config = function()
        --     require('config/plugins/general/misc')
        -- end,
    },

    -- -----------------------------------------------
    -- UI/LOOK
    -- -----------------------------------------------

    -- Icon set ---------------------------------
    {
        'kyazdani42/nvim-web-devicons',
        lazy = true,
        -- config = function()
        --     require('config/plugins/general/misc')
        -- end,
    },
    -- Add git related info in the signs columns and popups
    {
        'lewis6991/gitsigns.nvim',
        lazy = true,
        -- config = function()
        --     require('config/plugins/general/misc')
        -- end,
    },
    -- Statusline ------------------------------------
    {
        'rebelot/heirline.nvim',
        event = "VimEnter",
        dependencies = {'kyazdani42/nvim-web-devicons', 'lewis6991/gitsigns.nvim'},
        config = function()
            require('config/plugins/general/statusline/heirline')
        end,
    },
    -- StartScreen -----------------------------------
    {
        'goolord/alpha-nvim',
        event = "VimEnter",
        config = function()
            require('config/plugins/general/alpha')
        end,
    },
    -- Align code for eg, arround '=' sign ---------
    {
        'Vonr/align.nvim',
        branch = "v2",
        -- config = function()
        --     require('config/plugins/general/misc')
        -- end,
    },
    -- Highlight, navigate, and operate on sets of matching text
    {
        'andymass/vim-matchup',
        event = "VimEnter",
        config = function()
            require('config/plugins/general/vim-matchup')
        end,
    },
    -- Show colours around hex code ------------------
    {
        'NvChad/nvim-colorizer.lua',
        lazy = true,
        -- config = function()
        --     require('config/plugins/general/misc')
        -- end,
    },
    -- Highlight cursorline during jump ---------------
    {
        'cxwx/specs.nvim',
        commit = "dd82496",
        event = {"BufReadPost", "BufNewFile"},
        -- config = function()
        --     require('config/plugins/general/misc')
        -- end,
    },
    -- {
    --     'danilamihailov/beacon.nvim'
    -- },
    -- Show marks and bookmarks -------------------
    {
        'chentoast/marks.nvim',
        event = {"BufReadPost", "BufNewFile"},
        config = function()
            require('config/plugins/general/marks')
        end,
    },
    -- Registers in floating window and other convenience
    {
        "tversteeg/registers.nvim",
        keys = { "\"" },
        config = function()
            require("registers").setup()
        end,
    },

})
require('config/plugins/general/misc')
