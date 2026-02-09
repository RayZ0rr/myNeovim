local ok, lazy = pcall(require, "lazy")
if not ok then
  print('[Error] (pluginsList.lua): lazy.nvim not found. Skipping loading of plugins.')
  return
end

local hl_update = require('config/options/utils').hlUpdate
local hl_set = require('config/options/utils').hlSet

-- ########################################################
-- All the used plugins
-- ########################################################

local plugins = {
    ----------------------------------------------
    -- THEMES
    ----------------------------------------------

    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 2000,
        config = function()
            require('config/plugins/themes/kanagawa')
        end
    },
    -- -- Everforest Theme -----------------------------
    -- {
    --     'sainnhe/everforest',
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         vim.g.everforest_enable_italic = true
    --         vim.g.everforest_better_performance = 1
    --         vim.g.everforest_background = 'hard'
    --         vim.g.everforest_diagnostic_virtual_text = "colored"
    --         vim.g.everforest_float_style = 'dim' -- `'bright'`, `'dim'`, `'blend'`
    --         -- vim.g.everforest_ui_contrast = 'high'
    --         -- vim.g.everforest_colors_override = {fg = {'#dddddd', '000'}}
    --         -- vim.api.nvim_create_autocmd('ColorScheme', {
    --         --     group = vim.api.nvim_create_augroup('custom_highlights_everforest', {}),
    --         --     pattern = 'everforest',
    --         --     callback = function()
    --         --         local config = vim.fn['everforest#get_configuration']()
    --         --         local palette0 = vim.fn['everforest#get_palette'](config.background, config.colors_override)
    --         --         local palette1 = vim.fn['everforest#get_palette'](config.foreground, config.colors_override)

    --         --         hl_set('YankHighlightGroup', {fg=palette0.bg1[1], bg=palette0.yellow[1], default=false})
    --         --         hl_update('MatchParen', {fg=palette1.orange[1], bg=palette0.bg0[1]})
    --         --         hl_update('MatchWord', {fg=palette1.orange[1], italic=true})
    --         --         hl_update('MatchWordCur', {fg=palette1.orange[1], italic=true})
    --         --         hl_update('MatchWordCur', {fg=palette1.orange[1], italic=true})
    --         --         hl_update('Statusline', {bg=palette0.bg0[1]})
    --         --         -- hl_update('StatuslineNC', {bg=palette0.bg0[1]})
    --         --     end
    --         -- })
    --         -- vim.cmd.colorscheme('everforest')
    --         -- vim.api.nvim_set_hl(0, 'YankHighlightGroup', {link='WarningLine'})
    --     end
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
        event = {"BufReadPost", "BufNewFile"},
        config = function()
            require('config/plugins/LSP/utils/aerial')
        end,
    },

    -- --------------------------------------------------
    -- -- Treesitter
    -- --------------------------------------------------

    -- Highlight, edit, and navigate code using a fast incremental parsing library
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        branch = 'main',
        build = ':TSUpdate',
        config = function()
            require('config/plugins/treesitter/settings')
        end,
    },
    -- Additional textobjects for treesitter
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        init = function()
            -- Disable entire built-in ftplugin mappings to avoid conflicts.
            -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
            vim.g.no_plugin_maps = true
            -- Or, disable per filetype (add as you like)
            -- vim.g.no_python_maps = true
            -- vim.g.no_ruby_maps = true
            -- vim.g.no_rust_maps = true
            -- vim.g.no_go_maps = true
        end,
        dependencies = {'nvim-treesitter/nvim-treesitter'}
    },

    -- --------------------------------------------------
    -- -- Utilities
    -- --------------------------------------------------

    -- FZF ----------------------------------------
    {
        'ibhagwan/fzf-lua',
        -- keys = {"<C-p>", "<leader>f", "<leader>g"},
        dependencies = {
            'kyazdani42/nvim-web-devicons'
        }, -- optional for icons
        config = function()
            require('config/plugins/general/fzf-lua')
        end,
    },
    -- Undo history ------------------------------
    {
        'mbbill/undotree',
    },
    -- Better Yank (Cycle paste, more history, etc) ---------------------------
    {
        'gbprod/yanky.nvim',
        event = "VimEnter",
        dependencies = {
            { "kkharji/sqlite.lua" }
        },
        config = function()
            require('config/plugins/general/yanky')
        end,
    },
    -- Autocompletion plugin ---------------------
    {
        'hrsh7th/nvim-cmp',
        event = {"InsertEnter", "CmdlineEnter"},
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
        event = "InsertEnter",
        dependencies = { "rafamadriz/friendly-snippets" },
    },
    -- Surround with characters -------------------
    {
        "tpope/vim-surround",
        event = "InsertEnter",
    },
    -- -- Trailing whitspaces higlight and trim ------
    {
        'ntpeters/vim-better-whitespace',
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
    -- Better git tools --------------------------
    {'tpope/vim-fugitive'},
    -- Better quickfix --------------------------
    {'kevinhwang91/nvim-bqf', ft = 'qf'},
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
        keys = { "<leader>t" },
        config = function()
            require('config/plugins/general/floaterm')
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
    },

    -- -----------------------------------------------
    -- UI/LOOK
    -- -----------------------------------------------

    -- Statusline ------------------------------------
    {
        'RayZ0rr/mini.statusline', version = false,
        lazy = false,
        priority = 100,
        dependencies = {'kyazdani42/nvim-web-devicons', 'lewis6991/gitsigns.nvim'},
        config = function()
            require('config/plugins/general/statusline/miniline')
        end,
    },
    -- Icon set ---------------------------------
    {
        'kyazdani42/nvim-web-devicons',
        lazy = true,
    },
    -- Add git related info in the signs columns and popups
    {
        'lewis6991/gitsigns.nvim',
        lazy = true,
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
    },
    -- Highlight, navigate, and operate on sets of matching text
    {
        'andymass/vim-matchup',
        config = function()
            require('config/plugins/general/vim-matchup')
        end,
    },
    -- Show colours around hex code ------------------
    {
        'NvChad/nvim-colorizer.lua',
        lazy = true,
    },
    -- Highlight cursorline during jump ---------------
    {
        "y3owk1n/undo-glow.nvim",
        version = "*",
        event = {"BufReadPost", "BufNewFile"},
        config = function()
            require('config/plugins/general/undo-glow')
        end,
    },
    -- Show marks and bookmarks -------------------
    {
        'chentoast/marks.nvim',
        event = {"BufReadPost", "BufNewFile"},
        config = function()
            require('config/plugins/general/marks')
        end,
    },

    -- {
    --     "olimorris/codecompanion.nvim",
    --     config = function()
    --         require('config/plugins/general/codecompanion')
    --     end,
    --     dependencies = {
    --         "ravitemer/codecompanion-history.nvim",
    --         "nvim-lua/plenary.nvim",
    --         "nvim-treesitter/nvim-treesitter",
    --     },
    --     tag = "v17.33.0",
    -- },
}
require('lazy').setup(plugins)
require('config/plugins/general/misc')
