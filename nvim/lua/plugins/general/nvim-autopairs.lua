
-- local cfg = {
-- 		disable_filetype = {"fzf-lua", "TelescopePrompt" , "vim" },
		-- ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", "") -- default value
		-- enable_moveright = true -- default value
		-- enable_afterquote = true  -- default value (add bracket pairs after quote)
		-- enable_check_bracket_line = true  --- default value (check bracket in same line)
		-- check_ts = false --default value
-- }

require('nvim-autopairs').setup({
  disable_filetype = {"Fzf","TelescopePrompt","fm","NvimTree" },
  -- ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
  -- fast_wrap = {},
  check_ts = true,
  fast_wrap = {
    map = '<M-e>',
    chars = { '{', '[', '(', '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
    offset = -1, -- Offset from pattern match
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    hightlight = 'Search',
    highlight_grey='Comment'
  },
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } } ) )
-- require('nvim-autopairs').setup({
--   disable_filetype = { "TelescopePrompt" , "vim" },
-- })

local npairs = require'nvim-autopairs'
local Rule   = require'nvim-autopairs.rule'

npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({ '()', '[]', '{}' }, pair)
    end),
  Rule('( ', ' )')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%)') ~= nil
      end)
      :use_key(')'),
  Rule('{ ', ' }')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%}') ~= nil
      end)
      :use_key('}'),
  Rule('[ ', ' ]')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%]') ~= nil
      end)
      :use_key(']')
}
