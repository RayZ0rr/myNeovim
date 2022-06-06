local if_nil = vim.F.if_nil

local alpha = require'alpha'
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
    -- local total_plugins = #vim.tbl_keys(packer_plugins)
    local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
    local version = vim.version()
    local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

    return datetime .. "   " ..  nvim_version_info
    -- return datetime .. "   " .. total_plugins .. " plugins" .. nvim_version_info
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

--- @param sc string
--- @param txt string
--- @param keybind string optional
--- @param keybind_opts table optional
local function button(sc, txt, keybind, keybind_opts)
  local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

  local opts = {
    position = "center",
    shortcut = sc,
    cursor = 5,
    width = 50,
    hl = "Label",
    align_shortcut = "right",
    hl_shortcut = "Keyword",
  }
  if keybind then
    keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
    -- opts.keymap = { "n", sc_, keybind, keybind_opts }
    opts.keymap = { "n", sc_, "<cmd>" .. keybind .. "<cr>", keybind_opts }
  end

  local function on_press()
    local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
    -- vim.api.nvim_feedkeys(key, "normal", false)
    vim.cmd(keybind)
  end

  return {
    type = "button",
    val = txt,
    on_press = on_press,
    opts = opts,
  }
end

local buttons = {
  type = "group",
  val = {
    button("e", "  New file", "ene"),
    button("f", "  File Explorer","FzfLua files"),
    button("o", "  Recently opened files","FzfLua oldfiles"),
    button("g", "  Find word","FzfLua grep_project"),
    button("m", "  Jump to bookmarks","lua require('fzf-lua').marks()"),
    button("s", "  Open last session","SessionManager load_session"),
    -- button("SPC f f", "  Find file","lua require('fzf-lua').files()"),
    -- button("SPC f o", "  Recently opened files","FzfLua oldfiles"),
    -- button("SPC f g g", "  Find word","FzfLua grep_project"),
    -- button("SPC f m", "  Jump to bookmarks","lua require('fzf-lua').marks()"),
    -- button("SPC s l", "  Open last session"),
  },
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
