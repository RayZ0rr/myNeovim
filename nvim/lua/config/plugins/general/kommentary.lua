
local map = require('config/options/utils').map

vim.g.kommentary_create_default_mappings = false
local keyname = "<C-/>"
if string.find(vim.env['TERM'], "tmux") then
    keyname = "<C-_>"
end
map({"n"}, keyname, "<Plug>kommentary_line_default", {remap = true})
map({"n"}, "<leader>" .. keyname, "<Plug>kommentary_motion_default", {remap = true})
map({"x"}, keyname, "<Plug>kommentary_visual_default<C-c>", {remap = true})

-- require('kommentary.config').use_extended_mappings()

map({"n"}, "<leader>gcic", "<Plug>kommentary_line_increase", {remap = true})
map({"n"}, "<leader>gci", "<Plug>kommentary_motion_increase", {remap = true})
map({"x"}, "<leader>gci", "<Plug>kommentary_visual_increase", {remap = true})
map({"n"}, "<leader>gcdc", "<Plug>kommentary_line_decrease", {remap = true})
map({"n"}, "<leader>gcd", "<Plug>kommentary_motion_decrease", {remap = true})
map({"x"}, "<leader>gcd", "<Plug>kommentary_visual_decrease", {remap = true})

require('kommentary.config').configure_language("default", {
  prefer_single_line_comments = true,
  -- prefer_multi_line_comments = true,
  -- use_consistent_indentation = true -- default value
  -- ignore_whitespace = true -- default value
})

require('kommentary.config').configure_language("cpp", {
  single_line_comment_string = "//",
  multi_line_comment_strings = {"/*", "*/"},
})

require('kommentary.config').configure_language("rust", {
  single_line_comment_string = "//",
  multi_line_comment_strings = {"/*", "*/"},
})

kommentary_config = require("kommentary.config")
-- local langs = kommentary_config.config -- all default supported langs
local langs = { "lua" , "vim" }
for lang, _ in pairs(langs) do
  kommentary_config.configure_language(lang, {
    single_line_comment_string = "auto",
    multi_line_comment_strings = "auto",
    prefer_multi_line_comments = false,
    use_consistent_indentation = true,
    ignore_whitespace = true,
    hook_function = function()
      require("ts_context_commentstring.internal").update_commentstring()
    end,
  })
end

-- require('kommentary.config').configure_language({"lua", "vim"}, {
--   hook_function = function()
--     vim.api.nvim_buf_set_option(0, 'commentstring', '{%s}')
--   end,
--   single_line_comment_string = "auto",
--   multi_line_comment_strings = "auto"
--   -- hook_function = function()
--   --   require('ts_context_commentstring.internal').update_commentstring()
--   -- end,
-- })
