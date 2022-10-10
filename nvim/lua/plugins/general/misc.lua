local plugins_path = vim.fn.stdpath('data')..'/site/pack/*/start/'
local nnmap = require('options/utils').nnmap
local xnmap = require('options/utils').xnmap

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
local present, _ = pcall(require, 'replacer')
if present then
  nnmap('<Leader>qf', ':lua require("replacer").run()<cr>', { nowait = true, silent = true })

-- else
--   print("gabrielpoca/replacer.nvim not installed")
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
-- else
--   print("wincent/ferret not installed")
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

-- else
--   print("junegunn/vim-easy-align not installed")
end

--##########################################################################################################
-- vim illuminate -----------------------------------------------------------------------------------------
--##########################################################################################################
-- :echo synIDattr(synID(line("."), col("."), 1), "name")
-- Time in milliseconds (default 0)
-- vim.g.Illuminate_delay = 0
-- let g:Illuminate_delay = 0
local present, _ = pcall(require, 'illuminate')
if present then
  vim.g.Illuminate_ftblacklist = {'nerdtree', 'fern', 'fzf','nvimtree', 'term'}
  vim.api.nvim_command [[ hi def link LspReferenceText CursorLine ]]
  vim.api.nvim_command [[ hi def link LspReferenceWrite CursorLine ]]
  vim.api.nvim_command [[ hi def link LspReferenceRead CursorLine ]]
  nnmap('<a-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>')
  nnmap('<a-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>')
  nnmap('<leader>ill', [[:exe 'IlluminationToggle!' | echo "Illuminate toggled"<cr>]])
  -- Don't highlight word under cursor (default: 1)
  -- vim.g.Illuminate_highlightUnderCursor = 1
  vim.cmd[[
    augroup illuminate_augroup
	autocmd!
	autocmd VimEnter * hi illuminatedCurWord cterm=italic gui=italic
	autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
    augroup END
  ]]
-- else
--   print("RRethy/vim-illuminate not installed")
end

--##########################################################################################################
-- Vim-betterwhitespace------------------------------------------------------------------------------------
-- Show and remove trailing whitespaces
--##########################################################################################################
if vim.fn.empty(vim.fn.glob(plugins_path..'vim-better-whitespace')) == 0 then

  nnmap( ']w', ':NextTrailingWhitespace<CR>')
  nnmap( '[w', ':PrevTrailingWhitespace<CR>')

  nnmap( '<leader>wt', ':ToggleWhitespace | echo "Whitspace toggled"<CR><CR>')
  nnmap( '<leader>wr', ':StripWhitespace<CR>')
  nnmap( '<leader>ws', ':ToggleStripWhitespaceOnSave | echo "Whitspace strip on save toggled"<CR><CR>')

  -- vim.cmd[[autocmd FileType * ToggleWhitespace]]

  vim.g.better_whitespace_operator=',ww'

  vim.g.better_whitespace_enabled=1
  vim.g.strip_whitespace_on_save=0
  -- vimg.g.strip_whitespace_confirm=1
  vim.g.current_line_whitespace_disabled_hard=1
  -- vim.g.current_line_whitespace_disabled_soft=1
  vim.g.better_whitespace_filetypes_blacklist={'fzf', 'floaterm', 'toggleterm', 'term', 'fm', 'replacer', 'netrw', 'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'fugitive'}
-- else
--   print("ntpeters/vim-better-whitespace not installed")
end

--##########################################################################################################
-- nvim web devicons---------------------------------------------------------------------------------------
--##########################################################################################################
local present, _ = pcall(require, 'nvim-web-devicons')
if present then
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
-- else
--   print("kyazdani42/nvim-web-devicons not installed")
end

--##########################################################################################################
-- Gitsigns ---------------------------------------------------------------------------------------
--##########################################################################################################
local present, _ = pcall(require, 'gitsigns.nvim')
if present then
  require('gitsigns').setup()
-- else
--   print("lewis6991/gitsigns.nvim not installed")
end

--##########################################################################################################
-- Colorizer setup-----------------------------------------------------------------------------------------
--##########################################################################################################
local present, _ = pcall(require, 'colorizer')
if present then
  local colorizer_cfg = {
    filetypes = { "*" },
    user_default_options = {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = true, -- "Name" codes like Blue or blue
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
  nnmap('<leader>clr', ':exec "ColorizerToggle" | echo "Colorizer toggled"<cr>')

-- else
--   print("norcalli/nvim-colorizer.lua not installed")
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
local present, _ = pcall(require, 'specs')
if present then
  require('specs').setup{
    show_jumps  = true,
    min_jump = 10,
    popup = {
      delay_ms = 0, -- delay before popup displays
      inc_ms = 3, -- time increments used for fade/resize effects
      blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
      width = 80,
      winhl = "DiffAdd",
      fader = require('specs').pulse_fader,
      -- resizer = require('specs').empty_resizer
      resizer = require('specs').shrink_resizer
    },
    ignore_filetypes = {},
    ignore_buftypes = {
	nofile = true,
    },
  }

  nnmap('<leader>spt', function() require('specs').toggle() print("Specs toggled") end, {desc="Toggle specs function"})
  nnmap('<leader>spp', [[<cmd>lua require('specs').show_specs()<cr>]])

-- else
--   print("edluffy/specs.nvim not installed")
end

--##########################################################################################################
-- Beacon -------------------------------------------------------------------------------------------------
-- Highlight cursor on jump
--##########################################################################################################
if vim.fn.empty(vim.fn.glob(plugins_path..'beacon.nvim')) == 0 then
  vim.cmd [[
  augroup MyBeaconGroup
    autocmd!
    au WinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
  augroup end
  ]]

  -- vim.cmd[[highlight link Beacon String]]
  -- vim.cmd[[highlight Beacon guibg=white ctermbg=15]]
  vim.cmd[[highlight BeaconDefault guibg=yellow ctermbg=15]]
  vim.g.beacon_enable = 1
  vim.g.beacon_size = 40
  vim.g.beacon_show_jumps = 1
  vim.g.beacon_minimal_jump = 10
  vim.g.beacon_shrink = 1
  vim.g.beacon_fade = 1
  -- vim.g.beacon_timeout = 500
  -- vim.g.beacon_ignore_buffers = {\w*git*\w}
  vim.g.beacon_ignore_filetypes = {'fzf'}

  nnmap('<leader>bect',':BeaconToggle | echo "Beacon toggled"<cr>')
  nnmap('<leader>becc',':Beacon<cr>')
-- else
--   print("DanilaMihailov/beacon.nvim not installed")
end
