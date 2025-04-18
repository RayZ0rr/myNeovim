-- Settings
local fzf_lua = require('fzf-lua')
local actions = require "fzf-lua.actions"

fzf_lua.setup {
    -- fzf_bin         = 'sk',            -- use skim instead of fzf?
    -- https://github.com/lotabout/skim
    -- can also be set to 'fzf-tmux'
    -- fzf_bin         = 'fzf-tmux',
    winopts = {
        fullscreen = true,
        border  = { " ", " ", " ", " ", "", "", "", " " },
        preview = {
            layout = 'vertical',
        }
    },
    previewers = {
        builtin = {
            -- fzf-lua is very fast, but it really struggled to preview a couple files
            -- in a repo. Those files were very big JavaScript files (1MB, minified, all on a single line).
            -- It turns out it was Treesitter having trouble parsing the files.
            -- With this change, the previewer will not add syntax highlighting to files larger than 100KB
            -- (Yes, I know you shouldn't have 100KB minified files in source control.)
            syntax_limit_b = 1024 * 100, -- 100KB
        },
    },
    actions = {
        buffers = {
            false,          -- do not inherit from defaults
            -- providers that inherit these actions:
            --   buffers, tabs, lines, blines
            ["default"]     = actions.buf_edit,
            ["ctrl-s"]      = actions.buf_split,
            ["ctrl-v"]      = actions.buf_vsplit,
            ["ctrl-t"]      = actions.buf_tabedit,
        }
    },
    fzf_opts = {
        -- options are sent as `<left>=<right>`
        -- set to `false` to remove a flag
        -- set to `true` for a no-value flag
        -- for raw args use `fzf_args` instead
        ["--ansi"]           = true,
        ["--info"]           = "inline-right", -- fzf < v0.42 = "inline"
        ["--height"]         = "100%",
        ["--layout"]         = "reverse",
        ["--border"]         = "block",
        ["--input-border"]   = "",
        ["--highlight-line"] = true,           -- fzf >= v0.53
    },
    -- Only used when fzf_bin = "fzf-tmux", by default opens as a
    -- popup 80% width, 80% height (note `-p` requires tmux > 3.2)
    -- and removes the sides margin added by `fzf-tmux` (fzf#3162)
    -- for more options run `fzf-tmux --help`
    -- NOTE: since fzf v0.53 / sk v0.15 it is recommended to use
    -- native tmux integration by adding the below to `fzf_opts`
    -- fzf_opts = { ["--tmux"] = "center,80%,60%" }
    fzf_tmux_opts = { ["-p"] = "80%,80%", ["--margin"] = "0,0" },
    --
    -- Set fzf's terminal colorscheme (optional)
    --
    -- Set to `true` to automatically generate an fzf's colorscheme from
    -- Neovim's current colorscheme:
    -- fzf_colors       = true,
    fzf_colors = {
        -- ["fg+"] = { "#151515" , { "Comment", "Normal" }, "bold", "underline" },
        -- ["fg+"] = "#151515:bold:underline",
        ["fg+"] = "#E8E3E3",
        ["bg+"] = "#424242",
        ["hl+"] = "#A988B0",
        ["input-bg"] = "#262A31",
        ["border"] = "#262A31",
        ["input-border"] = "#BBB6B6",
        -- -- ["bg+"] = "-1",
        -- -- It is also possible to pass raw values directly
        -- ["gutter"] = "-1"
    },
    --
    -- PROVIDERS SETUP
    -- use `defaults` (table or function) if you wish to set "global-provider" defaults
    -- for example, disabling file icons globally and open the quickfix list at the top
    --   defaults = {
    --     file_icons   = false,
    --     copen        = "topleft copen",
    --   },
    defaults = {
        -- prompt            = ' ',
        path_shorten              = false,
        formatter                 = "path.filename_first",
        cwd_header                = true,
        cwd_prompt                = false,
        hidden                    = true,
        follow                    = true,
        no_ignore                 = false,
    },
    -- files = {
    --     actions = {
    --         -- inherits from 'actions.files', here we can override
    --         -- or set bind to 'false' to disable a default action
    --         -- action to toggle `--no-ignore`, requires fd or rg installed
    --         ["ctrl-g"]         = { actions.toggle_ignore },
    --         -- uncomment to override `actions.file_edit_or_qf`
    --         ["default"]   = actions.file_edit,
    --         -- custom actions are available too
    --         ["ctrl-y"]    = function(selected) print(selected[1]) end,
    --     }
    -- },
    oldfiles = {
        include_current_session = true,
    },
    grep = {
        path_shorten              = true,
        -- executed command priority is 'cmd' (if exists)
        -- otherwise auto-detect prioritizes `rg` over `grep`
        -- default options are controlled by 'rg|grep_opts'
        -- cmd            = "rg --vimgrep",
        -- Set to 'true' to always parse globs in both 'grep' and 'live_grep'
        -- search strings will be split using the 'glob_separator' and translated
        -- to '--iglob=' arguments, requires 'rg'
        -- can still be used when 'false' by calling 'live_grep_glob' directly
        rg_glob           = false,        -- default to glob parsing?
        --
        -- Enable with narrow term width, split results to multiple lines
        -- NOTE: multiline requires fzf >= v0.53 and is ignored otherwise
        -- multiline      = 1,      -- Display as: PATH:LINE:COL\nTEXT
        -- multiline      = 2,      -- Display as: PATH:LINE:COL\nTEXT\n
        -- actions = {
        --     -- actions inherit from 'actions.files' and merge
        --     -- this action toggles between 'grep' and 'live_grep'
        --     ["default"]     = actions.file_edit_or_qf,
        -- },
        no_header             = false,    -- hide grep|cwd header?
        no_header_i           = false,    -- hide interactive header?
    },
    registers = {
        actions = {
            -- ['default'] = function(selected, _)
            --   local register = selected[1]:match('%[(.*)%]')
            --   local contents = vim.fn.getreg(register)
            --   vim.api.nvim_paste(contents, true, -1)
            -- end,
            ['ctrl-p'] = function(selected)
                local reg = selected[1]:match("%[(.-)%]")
                local ok, data = pcall(vim.fn.getreg, reg)
                if ok and #data > 0 then
                    vim.fn.setreg(vim.v.register, data)
                end
            end
        }
    },
}
-- Colors
require 'config/plugins/general/fzf-lua/colors'
-- Mappings
require 'config/plugins/general/fzf-lua/keymaps'
-- override default UI select
if vim.ui then
    -- fzf_lua.register_ui_select({
    --     winopts = {
    --         win_height = 0.30,
    --         win_width  = 0.70,
    --         win_row    = 0.40,
    --     }
    -- })
    fzf_lua.register_ui_select(function(o, items)
      local min_h, max_h = 0.15, 0.70
      local preview = o.kind == "codeaction" and 0.20 or 0
      local h = (#items + 4) / vim.o.lines + preview
      if h < min_h then
        h = min_h
      elseif h > max_h then
        h = max_h
      end
      return { winopts = { height = h, width = 0.60, row = 0.40 } }
    end)

end
