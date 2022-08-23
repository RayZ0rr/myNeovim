local onedarkpro = require("onedarkpro")
onedarkpro.setup({
  -- Theme can be overwritten with 'onedark' or 'onelight' as a string!
  theme = function()
    if vim.o.background == "dark" then
      return "onedark"
    else
      return "onelight"
    end
  end,
  -- Override default colors. Can specify colors for "onelight" or "onedark" themes by passing in a table
  colors = {
    onedark = {
      bg = "#1e1e1e" -- dark
    },
  },
  highlights = {  -- Override default highlight groups
    Cursorline = { bg="Grey20" , },
    Folded = { fg="Black", bg="Grey40" , },
    IncSearch = { fg='#4B4B4B' , bg="#e5c07b" },
  },
  plugins = { -- Override which plugins highlight groups are loaded
    native_lsp = true,
    polygot = false,
    treesitter = true,
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
onedarkpro.load()
