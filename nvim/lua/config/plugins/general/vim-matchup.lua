local nnmap = require('config/options/utils').nnmap

vim.g.matchup_matchparen_offscreen = { method = 'popup'}
vim.matchup_surround_enabled = 1
vim.matchup_delim_stopline = 1500
vim.g.matchup_matchparen_deferred = 1
vim.g.matchup_matchparen_deferred_show_delay = 50
vim.g.matchup_matchparen_deferred_hide_delay = 700
vim.g.matchup_matchparen_hi_surround_always = 1

nnmap('<leader>muh' , '<plug>(matchup-hi-surround)')
nnmap('<leader>muw', '<cmd>MatchupWhereAmI?<cr>')
