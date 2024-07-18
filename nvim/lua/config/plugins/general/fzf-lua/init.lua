-- Settings
local fzf_lua = require('fzf-lua')
local actions = require "fzf-lua.actions"

if vim.ui then
  fzf_lua.register_ui_select({
    winopts = {
      win_height = 0.30,
      win_width  = 0.70,
      win_row    = 0.40,
    }
  })
end

fzf_lua.setup {
  -- fzf_bin         = 'sk',            -- use skim instead of fzf?
                                        -- https://github.com/lotabout/skim
                                        -- can also be set to 'fzf-tmux'
  actions = {
    -- Below are the default actions, setting any value in these tables will override
    -- the defaults, to inherit from the defaults change [1] from `false` to `true`
    files = {
      false,          -- do not inherit from defaults
      -- providers that inherit these actions:
      --   files, git_files, git_status, grep, lsp
      --   oldfiles, quickfix, loclist, tags, btags
      --   args
      -- default action opens a single selection
      -- or sends multiple selection to quickfix
      -- replace the default action with the below
      -- to open all files whether single or multiple
      ["default"]     = actions.file_edit,
      ["ctrl-s"]      = actions.file_split,
      ["ctrl-v"]      = actions.file_vsplit,
      ["ctrl-t"]      = actions.file_tabedit,
      ["alt-q"]       = actions.file_sel_to_qf,
      ["alt-l"]       = actions.file_sel_to_ll,
    },
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
    ["--border"]         = "none",
    ["--highlight-line"] = true,           -- fzf >= v0.53
  },
  -- Only used when fzf_bin = "fzf-tmux", by default opens as a
  -- popup 80% width, 80% height (note `-p` requires tmux > 3.2)
  -- and removes the sides margin added by `fzf-tmux` (fzf#3162)
  -- for more options run `fzf-tmux --help`
  fzf_tmux_opts       = { ["-p"] = "80%,80%", ["--margin"] = "0,0" },
  --
  -- Set fzf's terminal colorscheme (optional)
  --
  -- Set to `true` to automatically generate an fzf's colorscheme from
  -- Neovim's current colorscheme:
  -- fzf_colors       = true,
  --
  -- PROVIDERS SETUP
  -- use `defaults` (table or function) if you wish to set "global-provider" defaults
  -- for example, disabling file icons globally and open the quickfix list at the top
  --   defaults = {
  --     file_icons   = false,
  --     copen        = "topleft copen",
  --   },
  files = {
    previewer      = "bat",          -- uncomment to override previewer
                                        -- (name from 'previewers' table)
                                        -- set to 'false' to disable
    toggle_ignore_flag = "--no-ignore", -- flag toggled in `actions.toggle_ignore`
    toggle_hidden_flag = "--hidden",    -- flag toggled in `actions.toggle_hidden`
    actions = {
      -- inherits from 'actions.files', here we can override
      -- or set bind to 'false' to disable a default action
      -- action to toggle `--no-ignore`, requires fd or rg installed
      ["ctrl-g"]         = { actions.toggle_ignore },
      -- uncomment to override `actions.file_edit_or_qf`
        ["default"]   = actions.file_edit,
      -- custom actions are available too
        ["ctrl-y"]    = function(selected) print(selected[1]) end,
    }
  },
  grep = {
    prompt            = 'Rg❯ ',
    input_prompt      = 'Grep For❯ ',
    multiprocess      = true,           -- run command in a separate process
    git_icons         = true,           -- show git icons?
    file_icons        = true,           -- show file icons?
    color_icons       = true,           -- colorize file|git icons
    -- executed command priority is 'cmd' (if exists)
    -- otherwise auto-detect prioritizes `rg` over `grep`
    -- default options are controlled by 'rg|grep_opts'
    -- cmd            = "rg --vimgrep",
    grep_opts         = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp -e",
    rg_opts           = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
    -- Uncomment to use the rg config file `$RIPGREP_CONFIG_PATH`
    -- RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH
    --
    -- Set to 'true' to always parse globs in both 'grep' and 'live_grep'
    -- search strings will be split using the 'glob_separator' and translated
    -- to '--iglob=' arguments, requires 'rg'
    -- can still be used when 'false' by calling 'live_grep_glob' directly
    rg_glob           = false,        -- default to glob parsing?
    glob_flag         = "--iglob",    -- for case sensitive globs use '--glob'
    glob_separator    = "%s%-%-",     -- query separator pattern (lua): ' --'
    -- advanced usage: for custom argument parsing define
    -- 'rg_glob_fn' to return a pair:
    --   first returned argument is the new search query
    --   second returned argument are additional rg flags
    -- rg_glob_fn = function(query, opts)
    --   ...
    --   return new_query, flags
    -- end,
    --
    -- Enable with narrow term width, split results to multiple lines
    -- NOTE: multiline requires fzf >= v0.53 and is ignored otherwise
    -- multiline      = 1,      -- Display as: PATH:LINE:COL\nTEXT
    -- multiline      = 2,      -- Display as: PATH:LINE:COL\nTEXT\n
    actions = {
      -- actions inherit from 'actions.files' and merge
      -- this action toggles between 'grep' and 'live_grep'
      ["default"]     = actions.file_edit_or_qf,
      ["ctrl-g"]      = { actions.grep_lgrep }
      -- uncomment to enable '.gitignore' toggle for grep
      -- ["ctrl-r"]   = { actions.toggle_ignore }
    },
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
