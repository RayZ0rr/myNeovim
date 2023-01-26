local onedarkpro = require("onedarkpro")
onedarkpro.setup({
  -- Theme can be overwritten with 'onedark' or 'onelight' as a string!
  -- theme = function()
  --   if vim.o.background == "dark" then
  --     return "onedark"
  --   else
  --     return "onelight"
  --   end
  -- end,
  dark_theme = "onedark", -- The default dark theme
  light_theme = "onelight", -- The default light theme
  caching = true, -- Use caching for the theme?
  cache_path = vim.fn.expand(vim.fn.stdpath("cache") .. "/onedarkpro/"), -- The path to the cache directory
  -- Override default colors. Can specify colors for "onelight" or "onedark" themes by passing in a table
  colors = {
    onedark = {
      bg = "#1e1e1e" -- dark
    },
  },
  highlights = {  -- Override default highlight groups
    -- Cursorline = { bg="Grey20" , },
    Folded = { fg="Black", bg="Grey40" , },
    StatusLine = { bg = "NONE", fg = "NONE" },
  },
  plugins = { -- Override which plugins highlight groups are loaded
    all = false,
    aerial = true,
    marks = true,
    native_lsp = true,
    nvim_cmp = true,
    packer = true,
    treesitter = true,
  },
  styles = { -- Choose from "bold,italic,underline"
      types = "NONE", -- Style that is applied to types
      numbers = "NONE", -- Style that is applied to numbers
      strings = "NONE", -- Style that is applied to strings
      comments = "italic", -- Style that is applied to comments
      keywords = "italic", -- Style that is applied to keywords
      constants = "NONE", -- Style that is applied to constants
      functions = "NONE", -- Style that is applied to functions
      operators = "NONE", -- Style that is applied to operators
      variables = "NONE", -- Style that is applied to variables
      conditionals = "NONE", -- Style that is applied to conditionals
      virtual_text = "NONE", -- Style that is applied to virtual text
  },
  options = {
      bold = false, -- Use the colorscheme's opinionated bold styles?
      italic = true, -- Use the colorscheme's opinionated italic styles?
      underline = true, -- Use the colorscheme's opinionated underline styles?
      undercurl = true, -- Use the colorscheme's opinionated undercurl styles?
      cursorline = false, -- Use cursorline highlighting?
      transparency = false, -- Use a transparent background?
      terminal_colors = false, -- Use the colorscheme's colors for Neovim's :terminal?
      window_unfocused_color = false, -- When the window is out of focus, change the normal background?
  }
})
vim.o.background = "dark" -- to load onedark
vim.cmd("colorscheme onedark")  -- Lua
