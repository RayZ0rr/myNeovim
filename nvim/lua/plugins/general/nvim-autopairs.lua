local has_autopairs, autopairs = pcall(require, 'nvim-autopairs')
if not has_autopairs then
  return
end

autopairs.setup({
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

local has_cmp, cmp = pcall(require, "cmp")
if has_cmp then
  cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done { map_char = { tex = "" } })
end

local Rule   = require'nvim-autopairs.rule'

autopairs.add_rules {
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
