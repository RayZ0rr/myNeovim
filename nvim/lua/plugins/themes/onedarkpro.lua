local onedarkpro = require("onedarkpro")
onedarkpro.setup({
  -- Theme can be overwritten with 'onedark' or 'onelight' as a string!
  -- caching = false, -- Use caching for the theme?
  -- cache_path = vim.fn.expand(vim.fn.stdpath("cache") .. "/onedarkpro/"), -- The path to the cache directory
  -- theme = function()
  --   if vim.o.background == "dark" then
  --     return "onedark"
  --   else
  --     return "onelight"
  --   end
  -- end,
  dark_theme = "onedark", -- The default dark theme
  light_theme = "onelight", -- The default light theme
  -- Override default colors. Can specify colors for "onelight" or "onedark" themes by passing in a table
  colors = {
    onedark = {
      bg = "#1e1e1e" -- dark
    },
  },
  -- highlights = {  -- Override default highlight groups
  --   Cursorline = { bg="Grey20" , },
  --   Folded = { fg="Black", bg="Grey40" , },
  --   IncSearch = { fg='#4B4B4B' , bg="#e5c07b" },
  -- },
  plugins = { -- Override which plugins highlight groups are loaded
    native_lsp = true,
    treesitter = true,
    polygot = false,
    -- Others omitted for brevity
  },
  styles = {
    strings = "NONE", -- Style that is applied to strings
    comments = "italic", -- Style that is applied to comments
    keywords = "NONE", -- Style that is applied to keywords
    functions = "NONE", -- Style that is applied to functions
    variables = "NONE", -- Style that is applied to variables
  },
  options = {
    bold = true, -- Use the themes opinionated bold styles?
    italic = false, -- Use the themes opinionated italic styles?
    underline = true, -- Use the themes opinionated underline styles?
    undercurl = true, -- Use the themes opinionated undercurl styles?
    cursorline = false, -- Use cursorline highlighting?
    transparency = false, -- Use a transparent background?
    terminal_colors = false, -- Use the theme's colors for Neovim's :terminal?
    window_unfocussed_color = false, -- When the window is out of focus, change the normal background?
  }
})
vim.o.background = "dark" -- to load onedark
vim.cmd("colorscheme onedarkpro")  -- Lua
