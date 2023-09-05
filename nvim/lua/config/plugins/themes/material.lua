require('material').setup({

  contrast = {
    sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
    floating_windows = true, -- Enable contrast for floating windows
    cursor_line = true, -- Enable darker background for the cursor line
    non_current_windows = false, -- Enable darker background for non-current windows
    popup_menu = true, -- Enable lighter background for the popup menu
  },

  italics = {
    comments = true, -- Enable italic comments
    keywords = true, -- Enable italic keywords
    functions = false, -- Enable italic functions
    strings = false, -- Enable italic strings
    variables = false -- Enable italic variables
  },

  contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
    "terminal", -- Darker terminal background
    "packer", -- Darker packer background
    "qf", -- Darker qf list background
    "term", -- Darker qf list background
    "fzf", -- Darker qf list background
    "netrw", -- Darker qf list background
    "fm" -- Darker qf list background
  },

  high_visibility = {
    lighter = false, -- Enable higher contrast text for lighter style
    darker = false -- Enable higher contrast text for darker style
  },

  disable = {
    colored_cursor = false, -- Disable the colored cursor
    borders = false, -- Disable borders between verticaly split windows
    background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
    term_colors = false, -- Prevent the theme from setting terminal colors
    eob_lines = false -- Hide the end-of-buffer lines
  },

  async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

  custom_highlights = { -- Overwrite highlights with your own
    Cursorline = { bg="Grey20" , },
    Visual = { bg="Grey20" , },
    Folded = { fg="Black", bg="Grey40" , },
    IncSearch = { fg='#4B4B4B' , bg="#e5c07b" },
  },

  plugins = { -- Here, you can disable(set to false) plugins that you don't use or don't want to apply the theme to
    trouble = false,
    nvim_cmp = false,
    neogit = false,
    gitsigns = false,
    git_gutter = false,
    telescope = false,
    nvim_tree = false,
    sidebar_nvim = false,
    lsp_saga = false,
    nvim_dap = false,
    nvim_navic = false,
    which_key = false,
    sneak = false,
    hop = false,
    indent_blankline = false,
    nvim_illuminate = false,
    mini = false,
  }
})

vim.o.background = "dark" -- to load onedark
vim.g.material_style = "deep ocean"
vim.cmd 'colorscheme material'
