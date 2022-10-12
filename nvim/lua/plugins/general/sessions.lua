-- vim.cmd([[
--   let session_path = expand('~/.config/nvim/.sessionDir')
--   " create the directory and any parent directories
--   " if the location does not exist.
--   if !isdirectory(session_path)
--   call mkdir(session_path, "p", 0700)
--   endif
-- ]])

-- vim.o.sessionoptions="blank,buffers,curdir,help,tabpages,winsize,winpos,terminal"

local sessionPath = vim.fn.stdpath('data') .. '/.SessionsDir'
if vim.fn.isdirectory(viewPath) == 0 then
  vim.fn.system {
    'mkdir',
    '-p',
    sessionPath
  }
end

local Path = require('plenary.path')
require('session_manager').setup({
  sessions_dir = Path:new(vim.fn.stdpath('data'), '.SessionsDir'), -- The directory where the session files will be saved.
  path_replacer = '__', -- The character to which the path separator will be replaced for session files.
  colon_replacer = '++', -- The character to which the colon symbol will be replaced for session files.
  autoload_mode = require('session_manager.config').AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
  autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
    'gitcommit',
  },
  autosave_last_session = true, -- Automatically save last session on exit and on session switch.
  autosave_ignore_not_normal = true, -- Plugin will not save a session when no writable and listed buffers are opened.
  autosave_only_in_session = true, -- Always autosaves session. If true, only autosaves after a session is active.
  max_path_length = 80,  -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
})

local nnmap = require('options/utils').nnmap
nnmap('<leader>ss', [[<cmd>exe 'SessionManager save_current_session' | echo "session saved"<cr>]])
nnmap('<leader>sa', [[<cmd>exe 'SessionManager load_session' | echo "session loaded"<cr>]])
nnmap('<leader>sd', [[<cmd>exe 'SessionManager delete_session' | echo "session deleted"<cr>]])

local MySessionsGroup = vim.api.nvim_create_augroup('MySessionsGroup', { clear = true }) -- A global group for all your config autocommands

vim.api.nvim_create_autocmd('User', {
  pattern = 'SessionSavePost',
  group = MySessionsGroup,
  callback = function()
    print("Session has been saved")
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'SessionSavePost',
  group = MySessionsGroup,
  callback = function()
    print("Session has been loaded")
  end,
})
