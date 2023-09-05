local if_nil = vim.F.if_nil

local has_alpha, alpha = pcall(require, 'alpha')
if not has_alpha then
  return
end

local dashboard = require'alpha.themes.dashboard'

local default_header = {
  type = "text",
  val = {
    [[                               __                ]],
    [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
    [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
    [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
    [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
    [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
  },
  opts = {
    position = "center",
    hl = "Function",
    -- wrap = "overflow";
  },
}

local date = {
  type = "text",
  val = function()
    local clock = " " .. os.date("%H:%M")
    local date = " " .. os.date("%d-%m-%y")
    return { clock, date }
  end,
  opts = {
    position = "center",
    hl = "Number",
    shortcut = sc,
    cursor = 5,
    width = 50,
    align_shortcut = "right",
    hl_shortcut = "Keyword",

  },
}

local function pluginsCount()
    local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
    local version = vim.version()
    local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

    local has_packer, _ = pcall(require, 'packer')
    if not has_packer then
      return datetime .. "   " ..  nvim_version_info
    else
      local total_plugins = #vim.tbl_keys(packer_plugins)
      return datetime .. "   " .. total_plugins .. " plugins" .. nvim_version_info
    end
end

local footer1 = {
  type = "text",
  val = pluginsCount(),
  opts = {
    position = "center",
    hl = "Number",
  },
}

local fortune = require("alpha.fortune")

local footer2 = {
  type = "text",
  val = fortune(),
  opts = {
    position = "center",
    hl = "Title",
    -- hl = "Comment",
  },
}
local function button(sc, txt, keybind, keybind_opts)
  local b = dashboard.button(sc, txt, keybind, keybind_opts)
  b.opts.hl = "AlphaButtonText"
  b.opts.hl_shortcut = "AlphaButtonShortcut"
  b.opts.position = "center"
  b.opts.hl = "Label"
  b.opts.align_shortcut = "right"
  b.opts.hl_shortcut = "Keyword"
  b.cursor = 5
  b.width = 51
  return b
end

dashboard.section.buttons.val = {
  button("n", "   New file", ":ene <BAR> startinsert <CR>"),
  button("f", "  File Explorer",":FzfLua files show_header=true<CR>"),
  button("o", "  Recently opened files",":FzfLua oldfiles<CR>"),
  button("g", "  Find word",":FzfLua grep_project<CR>"),
  button("m", "  Jump to bookmarks",":lua require('fzf-lua').marks()<CR>"),
  button("u", "   Update plugins", ":PackerSync<CR>"), -- Packer sync
  button("s", "   Load session", ':SessionManager load_session<CR>'),
  button("q", "   Quit Neovim", ":qa!<CR>"),
}
local buttons = {
  type = "group",
  val = dashboard.section.buttons.val,
  opts = {
    spacing = 1,
  },
}

local section = {
  header = default_header,
  buttons = buttons,
  date = date,
  footer1 = footer1,
  footer2 = footer2,
}

local config = {
  layout = {
    section.header,
  { type = "padding", val = 3 },
    section.buttons,
  { type = "padding", val = 1 },
    section.footer1,
    section.footer2,
  -- { type = "padding", val = 2 },
  },
  opts = {
    margin = 5,
  },
}

alpha.setup(config)
