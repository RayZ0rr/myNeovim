local has_toggleterm, toggleterm = pcall(require, 'toggleterm')
if not has_toggleterm then
  return
end

toggleterm.setup{
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
  -- on_open = fun(t: Terminal), -- function to run when the terminal opens
  -- on_close = fun(t: Terminal), -- function to run when the terminal closes
  -- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
  -- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
  -- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
  -- shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  -- insert_mappings = true, -- whether or not the open mapping applies in insert mode
  -- terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  direction = 'float',  -- 'vertical' | 'horizontal' | 'tab' | 'float'
  close_on_exit = true, -- close the terminal window when the process exits
  shell = 'zsh',	  -- (vim.o.shell) change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = 'curved', -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    -- width = <value>,
    -- height = <value>,
    winblend = 3,
  }
}

-- nmap('n','<localleader>tt', [[<cmd>TermExec cmd="vf" dir="%:p:h"<CR>]], {noremap = true, silent = true})
nmap = require('config/options/utils').nnmap
bmap = require('config/options/utils').bmap
local executable = require("options.utils").executable

local Terminal  = require('toggleterm.terminal').Terminal
if executable('vifm') then
  local vifm_term = Terminal:new({
    cmd = "vf",
    dir = "%:p:h",
    direction = "float",
    float_opts = {
      border = "double",
    },
    -- function to run on opening the terminal
    on_open = function(term)
      vim.cmd("startinsert!")
      bmap("n", "<c-q>", "<cmd>close<CR>", {buffer = term.bufnr})
      bmap("t", "<cr>", "<cmd>edit<CR>", {buffer = term.bufnr})
    end,
  })
  function VifmToggle()
    vifm_term:toggle()
  end
  nmap("<leader>tt", "<cmd>lua VifmToggle()<CR>")
end

if executable('lazygit') then
  local lazygit_term = Terminal:new({
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
    float_opts = {
      border = "double",
    },
    -- function to run on opening the terminal
    on_open = function(term)
      vim.cmd("startinsert!")
      bmap( "n", "q", "<cmd>close<CR>", {buffer = term.bufnr} )
    end,
  })
  function LazygitToggle()
    lazygit_term:toggle()
  end
  nmap( "<leader>tg", "<cmd>lua LazygitToggle()<CR>" )
end

function _G.set_toggleterm_options()
  bmap('t', '<esc>', [[<C-\><C-n>]])
  bmap('t', 'jk', [[<C-\><C-n>]])
  bmap('t', '<C-h>', [[<C-\><C-n><C-W>h]])
  bmap('t', '<C-j>', [[<C-\><C-n><C-W>j]])
  bmap('t', '<C-k>', [[<C-\><C-n><C-W>k]])
  bmap('t', '<C-l>', [[<C-\><C-n><C-W>l]])
  vim.opt_local.signcolumn = 'no'
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_toggleterm_options()')

nmap("<leader>tr",":ToggleTerm<cr>")
