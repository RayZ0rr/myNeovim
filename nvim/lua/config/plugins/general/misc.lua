-- local plugins_path = vim.fn.stdpath('data')..'/site/pack/*/start/'
local plugins_path = vim.fn.stdpath('data')..'/lazy/'
local nnmap = require('config/options/utils').nnmap
local xnmap = require('config/options/utils').xnmap

--##########################################################################################################
-- Undotree ---------------------------------------------------------------------------------------------
-- Show undo history
--##########################################################################################################
if vim.fn.empty(vim.fn.glob(plugins_path..'undotree')) == 0 then
  -- if vim.fn.exists('g:undotree_WindowLayout') ~= 1 then
  --     vim.g.undotree_WindowLayout = 2
  -- end
  vim.g.undotree_WindowLayout = 2

  -- auto open diff window
  -- if not vim.fn.exists('g:undotree_DiffAutoOpen') then
  --     vim.g.undotree_DiffAutoOpen = 0
  -- end
  vim.g.undotree_DiffAutoOpen = 0

  -- if set, let undotree window get focus after being opened, otherwise
  -- focus will stay in current window.
  -- if not vim.fn.exists('g:undotree_SetFocusWhenToggle') then
  --    vim.g.undotree_SetFocusWhenToggle = 1
  -- end
  vim.g.undotree_SetFocusWhenToggle = 1
  nnmap('<leader>uu', ':UndotreeToggle<CR>')
  local MyUndoTreeMappingGroup = vim.api.nvim_create_augroup("MyUndoTreeMappingGroup", { clear = true })
  vim.api.nvim_create_autocmd(
    { "FileType" },
    { pattern = "undotree", command = [[nmap <buffer> <c-q> q]], group = MyUndoTreeMappingGroup }
  )
-- else
--   print("mbbill/undotree not installed")
end

--##########################################################################################################
-- Better Quickfix ---------------------------------------------------------------------------------------------
-- QF editable in both content and file path.
--##########################################################################################################
local ok_replacer, _ = pcall(require, 'replacer')
if ok_replacer then
  nnmap('<Leader>qf', require("replacer").run, { desc = "qf replacer activate", nowait = true, silent = true })
end

--##########################################################################################################
-- Ferret ---------------------------------------------------------------------------------------------
-- Enhanced multi-file search for Vim
--##########################################################################################################
if vim.fn.empty(vim.fn.glob(plugins_path..'ferret')) == 0 then
  vim.g.FerretMap = 0
  -- nnmap('<leader>gg', [[:execute "normal \<Plug>(FerretAckWord) \<Plug>(FerretAcks)"<CR>]])
  nnmap('<leader>gg', [[:Ack <C-R><C-W><CR>:Acks /<C-R><c-w>//<left>]])
  xnmap('<leader>gf', [[y:Ack <C-R>"<CR>:Acks /<C-R>"//<left>]])
  nnmap('<leader>gb', [[<Plug>(FerretBack)]], {remap=true})
end

--##########################################################################################################
-- align.nvim ---------------------------------------------------------------------------------------------
-- minimal plugin for NeoVim for aligning lines
--##########################################################################################################
local ok_align, _ = pcall(require, 'align')
if ok_align then
  xnmap( 'gaa', function() require'align'.align_to_char({length=1, preview=true}) end) -- Aligns to 1 character, looking left
  xnmap( 'gas', function() require'align'.align_to_char({length=2, preview=true}) end) -- Aligns to 2 characters, looking left and with previews
  xnmap( 'gaw', function() require'align'.align_to_string({regex=false, preview=true}) end) -- Aligns to a string, looking left and with previews
  xnmap( 'gae', function() require'align'.align_to_string({regex=true, preview=true})  end) -- Aligns to a Lua pattern, looking left and with previews

  -- Example gawip to align a paragraph to a string, looking left and with previews
  nnmap(
      'gaw',
      function()
	  local a = require'align'
	  a.operator(
	      a.align_to_string,
	      { is_pattern = false, reverse = true, preview = true }
	  )
      end
  )
  -- Example gaaip to aling a paragraph to 1 character, looking left
  nnmap(
      'gaa',
      function()
	  local a = require'align'
	  a.operator(
	      a.align_to_char,
	      { reverse = true }
	  )
      end
  )
end

--##########################################################################################################
-- Vim-easy-align ---------------------------------------------------------------------------------------------
-- A Vim alignment plugin
--##########################################################################################################
if vim.fn.empty(vim.fn.glob(plugins_path..'vim-easy-align')) == 0 then

  -- Start interactive EasyAlign in visual mode (e.g. vipga)
  xnmap('ga' , '<Plug>(EasyAlign)' , {remap=true})

  -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nnmap('ga','<Plug>(EasyAlign)',{remap=true})

  vim.g.easy_align_bypass_fold = 1
  -- vim.g.easy_align_interactive_modes = {'l', 'r'}
  -- vim.g.easy_align_bang_interactive_modes = {'c', 'r'}
end

--##########################################################################################################
-- vim illuminate -----------------------------------------------------------------------------------------
--##########################################################################################################
local ok_illuminate, _ = pcall(require, 'illuminate')
if ok_illuminate then
  require('illuminate').configure({
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
        'lsp',
        'treesitter',
        'regex',
    },
    -- delay: delay in milliseconds
    delay = 100,
    -- filetype_overrides: filetype specific overrides.
    -- The keys are strings to represent the filetype while the values are tables that
    -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
    filetype_overrides = {},
    -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
    filetypes_denylist = {
        'dirvish',
        'fugitive',
    },
    -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
    filetypes_allowlist = {},
    -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
    modes_denylist = {},
    -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
    modes_allowlist = {},
    -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_denylist = {},
    -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_allowlist = {},
    -- under_cursor: whether or not to illuminate under the cursor
    under_cursor = false,
    -- large_file_cutoff: number of lines at which to use large_file_config
    -- The `under_cursor` option is disabled when this cutoff is hit
    large_file_cutoff = nil,
    -- large_file_config: config to use for large files (based on large_file_cutoff).
    -- Supports the same keys passed to .configure
    -- If nil, vim-illuminate will be disabled for large files.
    large_file_overrides = nil,
    disable_keymaps = true
  })
  nnmap(',ill', function() require('illuminate').toggle() print("Illuminate toggled") end, {desc="Toogle vim-illuminate"})
  nnmap('<M-h>', function() require('illuminate').goto_prev_reference() end, {desc="Goto prev vim-illuminate"})
  nnmap('<M-l>', function() require('illuminate').goto_next_reference() end, {desc="Goto next vim-illuminate"})
  vim.api.nvim_set_hl(0,'IlluminatedWordText',{italic = true})
  vim.api.nvim_set_hl(0,'IlluminatedWordRead',{underline = true, italic = true})
  vim.api.nvim_set_hl(0,'IlluminatedWordWrite',{underline = true, italic = true})
end

--##########################################################################################################
-- Vim-betterwhitespace------------------------------------------------------------------------------------
-- Show and remove trailing whitespaces
--##########################################################################################################
if vim.fn.empty(vim.fn.glob(plugins_path..'vim-better-whitespace')) == 0 then

  nnmap( ']w', ':NextTrailingWhitespace<CR>')
  nnmap( '[w', ':PrevTrailingWhitespace<CR>')

  nnmap( '<leader>wst', function() vim.cmd "ToggleWhitespace" print("Whitspace toggled") end, {desc="Whitespace toggle function"})
  nnmap( '<leader>wsr', '<cmd>StripWhitespace<CR>', {desc="Whitespace remove function"})
  nnmap( '<leader>wss', function() vim.cmd "ToggleStripWhitespaceOnSave" print("Whitspace strip on save toggled") end, {desc="Whitespace remove on save toggle function"})

  -- vim.cmd[[autocmd FileType * ToggleWhitespace]]

  vim.g.better_whitespace_operator=',ws'

  vim.g.better_whitespace_enabled=1
  vim.g.strip_whitespace_on_save=0
  -- vimg.g.strip_whitespace_confirm=1
  vim.g.current_line_whitespace_disabled_soft=1
  vim.g.better_whitespace_filetypes_blacklist={'fzf', 'floaterm', 'toggleterm', 'term', 'fm', 'replacer', 'netrw', 'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'fugitive'}
end

--##########################################################################################################
-- nvim web devicons---------------------------------------------------------------------------------------
--##########################################################################################################
local ok_icons, _ = pcall(require, 'nvim-web-devicons')
if ok_icons then
  require'nvim-web-devicons'.setup {
   -- your personnal icons can go here (to override)
   -- DevIcon will be appended to `name`
   override = {
    zsh = {
      icon = "",
      color = "#428850",
      name = "Zsh"
    }
   };
   -- globally enable default icons (default to false)
   -- will get overriden by `get_icons` option
   -- default = true;
  }
end

--##########################################################################################################
-- Gitsigns ---------------------------------------------------------------------------------------
--##########################################################################################################
local ok_gitsigns, _ = pcall(require, 'gitsigns')
if ok_gitsigns then
  require('gitsigns').setup()
end

--##########################################################################################################
-- Colorizer setup-----------------------------------------------------------------------------------------
--##########################################################################################################
local ok_colorizer, _ = pcall(require, 'colorizer')
if ok_colorizer then
  local colorizer_cfg = {
    filetypes = { "*" },
    user_default_options = {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = false, -- "Name" codes like Blue or blue
    RRGGBBAA = true, -- #RRGGBBAA hex codes
    AARRGGBB = true, -- 0xAARRGGBB hex codes
    rgb_fn = false, -- CSS rgb() and rgba() functions
    hsl_fn = false, -- CSS hsl() and hsla() functions
    css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
    -- Available modes for `mode`: foreground, background,  virtualtext
    mode = "background", -- Set the display mode.
    -- Available methods are false / true / "normal" / "lsp" / "both"
    -- True is same as normal
    tailwind = false, -- Enable tailwind colors
    -- parsers can contain values used in |user_default_options|
    sass = { enable = false, parsers = { css }, }, -- Enable sass colors
    virtualtext = "■",
    },
    -- all the sub-options of filetypes apply to buftypes
    buftypes = {},
  }
  require'colorizer'.setup(
    colorizer_cfg
  )
  nnmap('<leader>clr', ':exec "ColorizerToggle" | echo "Colorizer toggled"<cr>', {desc="Colorizer toggle function"})
end

--##########################################################################################################
-- Fastfold create text-object ----------------------------------------------------------------------------
--##########################################################################################################
if vim.fn.empty(vim.fn.glob(plugins_path..'FastFold')) == 0 then
  nnmap('zuz', [[<Plug>(FastFoldUpdate)]])
  -- vim.api.nvim_set_keymap('n','<SID>(DisableFastFoldUpdate)', '<Plug>(FastFoldUpdate)', {remap=true})
  vim.g.fastfold_savehook = 1
  vim.g.fastfold_fold_command_suffixes =  {'x','X','a','A','o','O','c','C','r','R','m','M','i','n','N'}
  vim.g.fastfold_fold_movement_commands = {']z', '[z', 'zj', 'zk'}
  vim.g.fastfold_minlines = 200  -- Default Value
  xnmap('iz',[[:<c-u>FastFoldUpdate<cr><esc>:<c-u>normal! ]zv[z<cr>]])
  xnmap('az',[[:<c-u>FastFoldUpdate<cr><esc>:<c-u>normal! ]zV[z<cr>]])
  -- vim.g.fastfold_skip_filetypes
-- else
--   print("Konfekt/FastFold not installed")
end

--##########################################################################################################
-- Specs -------------------------------------------------------------------------------------------------
-- Highlight cursor line on jumps
--##########################################################################################################
local ok_specs, _ = pcall(require, 'specs')
if ok_specs then
  vim.api.nvim_set_hl(0,"SpecsHighlightGroup",{ fg = '#C3E88D', reverse = true }) -- diff mode: Added line
  require('specs').setup{
    show_jumps  = true,
    min_jump = 10,
    popup = {
      delay_ms = 0, -- delay before popup displays
      inc_ms = 3, -- time increments used for fade/resize effects
      blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
      width = 80,
      winhl = "SpecsHighlightGroup",
      fader = require('specs').pulse_fader,
      -- resizer = require('specs').empty_resizer
      resizer = require('specs').shrink_resizer
    },
    ignore_filetypes = {},
    ignore_buftypes = {
	nofile = true,
    },
  }

  nnmap('<leader>spt', function() require('specs').toggle() print("Specs toggled") end, {desc="Specs toggle function"})
  nnmap('<leader>spp', function() require('specs').show_specs() end, {desc="Activate specs and show cursorline location."})

-- else
--   print("edluffy/specs.nvim not installed")
end

--##########################################################################################################
-- Beacon -------------------------------------------------------------------------------------------------
-- Highlight cursor on jump
--##########################################################################################################
local ok_beacon, _ = pcall(require, 'beacon')
if ok_beacon then
    local options = {
        -- enabled = function()
        --     if vim.bo.ft:find 'Neogit' then
        --         return false
        --     end
        --     return true
        -- end
        enabled = false, --- (boolean | fun():boolean) check if enabled
        speed = 2, --- integer speed at wich animation goes
        width = 40, --- integer width of the beacon window
        winblend = 70, --- integer starting transparency of beacon window
        fps = 60, --- integer how smooth the animation going to be
        min_jump = 10, --- integer what is considered a jump. Number of lines
        cursor_events = { 'CursorMoved' }, -- table<string> what events trigger check for cursor moves
        window_events = { 'WinEnter', 'FocusGained' }, -- table<string> what events trigger cursor highlight
        highlight = { fg = '#C3E88D', reverse = true }, -- vim.api.keyset.highlight table passed to vim.api.nvim_set_hl
    }
    require('beacon').setup(options)

    -- vim.api.nvim_set_hl(0, 'Beacon', { fg = '#C3E88D', reverse = true })

    nnmap('<leader>bec', require('beacon').highlight_cursor)
end
