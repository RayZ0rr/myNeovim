local plugAndConfig = {

  -- Let Paq (plugin manager) manage itself
  {"savq/paq-nvim"},

  --------------------------------------------------
  -- GENERAL
  --------------------------------------------------

  -- fzf ----------------------------------------
  -- {'vijaymarupudi/nvim-fzf'},
  {'ibhagwan/fzf-lua','plugins/general/fzf-lua'},
  -- Undo history ------------------------------
  {'mbbill/undotree',"plugins/general/misc"},
  -- Build, Run tasks (commands) in background asynchronously
  {'skywind3000/asyncrun.vim','plugins/general/asyncRunTasks'},
  -- File Browser ------------------------------
  {'is0n/fm-nvim','plugins/general/fm-nvim'},
  -- Autocompletion plugin ---------------------
  {'hrsh7th/cmp-cmdline'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-path'},
  {'hrsh7th/nvim-cmp','plugins/general/nvim-cmp'},
  -- Snippets plugin ----------------------------
  {'saadparwaiz1/cmp_luasnip'},
  {"rafamadriz/friendly-snippets"},
  {"L3MON4D3/LuaSnip"},
  -- Surround with characters -------------------
  {"tpope/vim-surround"},
  -- Auto-pair completion -----------------------
  {'windwp/nvim-autopairs','plugins/general/nvim-autopairs'},
  -- Trailing whitspaces higlight and trim ------
  {'ntpeters/vim-better-whitespace','plugins/general/misc'},
  -- Comment and Uncomment lines ----------------
  {'b3nj5m1n/kommentary','plugins/general/kommentary'},
  -- Auto-session maker -------------------------
  {'Shatur/neovim-session-manager','plugins/general/auto-session'},
  -- Faster Folding ------------------------------
  {'Konfekt/FastFold','plugins/general/misc'},

  --------------------------------------------------
  -- UI and THEMES
  --------------------------------------------------

  -- Onedark Theme -----------------------------
  {'olimorris/onedarkpro.nvim',"plugins/themes/onedarkpro"},

  -- Icon set ---------------------------------
  {'kyazdani42/nvim-web-devicons','plugins/general/misc'},
  -- StartScreen ------------------------------
  {'goolord/alpha-nvim','plugins/general/alpha'},
  -- Statusline ---------------------------------
  {'kyazdani42/nvim-web-devicons'},
  {'feline-nvim/feline.nvim','plugins/general/feline'},
  -- Tab/buffers display and customize -----------
  {'kyazdani42/nvim-web-devicons'},
  {'akinsho/bufferline.nvim','plugins/general/bufferline'},
  -- Align code for eg, arround '=' sign
  {'junegunn/vim-easy-align'},
  -- Add git related info in the signs columns and popups
  {'nvim-lua/plenary.nvim'},
  {'lewis6991/gitsigns.nvim','plugins/general/misc'},
  -- Spell check helper plugin ---------------------
  {'kamykn/popup-menu.nvim'},
  {'kamykn/spelunker.vim','plugins/general/spelunker'},
  -- highlight, navigate, and operate on sets of matching text
  {'andymass/vim-matchup','plugins/general/vim-matchup'},
  -- Show colours around hex code ------------------
  {'norcalli/nvim-colorizer.lua','plugins/general/misc'},
  -- Show colours around hex code -------------
  {'edluffy/specs.nvim','plugins/general/misc'},
  -- Show marks and bookmarks -------------------
  {'chentoast/marks.nvim','plugins/general/marks'},
  -- Registers in floating window and other convenience
  {"tversteeg/registers.nvim"},
  -- Improve the default UI hooks (vim.ui.select and vim.ui.input)
  {'stevearc/dressing.nvim','plugins/general/dressing'},
  -- Startup time measure --------------------------
  {'dstein64/vim-startuptime'},

  --------------------------------------------------
  -- LSP
  --------------------------------------------------

  -- Collection of configurations for built-in LSP client
  {'neovim/nvim-lspconfig','plugins/LSP/settings'},
  -- File Browser ------------------------------
  {'stevearc/aerial.nvim','plugins/LSP/utils/aerial'},
  -- Higlight occurances of word under cursor
  {'RRethy/vim-illuminate','plugins/general/misc'},

  --------------------------------------------------
  -- TREESITTER
  --------------------------------------------------

  -- Highlight, edit, and navigate code using a fast incremental parsing library
  {'nvim-treesitter/nvim-treesitter','plugins/treesitter/settings'},
  -- Additional textobjects for treesitter
  {'nvim-treesitter/nvim-treesitter-textobjects'},
  -- Context aware commenting using treesitter
  {'JoosepAlviste/nvim-ts-context-commentstring'},
}

local plugList = {}
local configList = {}

for idx, items in pairs(plugAndConfig) do
  plugList[idx] = items[1]
  if items[2] then
    table.insert(configList,items[2]);
  end
end

-- If you want to automatically ensure that paq-nvim is installed on any machine you clone your configuration to,
-- add the following snippet somewhere in your config before your first usage of paq:
local function clone_paq(path)
  if vim.fn.empty(vim.fn.glob(path)) > 0 then
    vim.fn.system {
      'git',
      'clone',
      '--depth=1',
      'https://github.com/savq/paq-nvim.git',
      path
    }
  end
end

local install_path = vim.fn.stdpath('data')..'/site/pack/paqs/start/paq-nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  clone_paq(install_path)
  -- paq_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/savq/paq-nvim.git', install_path})
  vim.cmd([[packadd paq-nvim]])
  require("paq")(plugList)
  require("paq").install()
  vim.notify([[Please exit NVIM and re-open, then run :PaqSync]])
  return
end

-- don't throw any error on first use by packer
local ok, paq = pcall(require, "paq")
if not ok then return end

require("paq")(plugList)

-- Load configs
for idx, config in pairs(configList) do
  require(config)
end
-- for idx, items in pairs(plugAndConfig) do
--   if items[2] then
--     require(items[2])
--   end
-- end

vim.cmd([[
augroup paq_user_config
autocmd!
autocmd BufWritePost pluginsConfig.lua source <afile> | echom "Updating and Recompiling plugins" | PaqSync
augroup end
]])
