
local nnmap = require('config/options/utils').nnmap
local inmap = require('config/options/utils').inmap
local vnmap = require('config/options/utils').vnmap
local xnmap = require('config/options/utils').xnmap

vim.g.kommentary_create_default_mappings = false
nnmap("<c-/><c-/>", "<Plug>kommentary_line_default", {})
inmap("<c-/>", "<Esc><Plug>kommentary_line_default<Ins>", {})
nnmap("<c-/>", "<Plug>kommentary_motion_default", {})
vnmap("<c-/>", "<Plug>kommentary_visual_default<C-c>", {})

-- require('kommentary.config').use_extended_mappings()

nnmap("<leader>gcic", "<Plug>kommentary_line_increase", {})
nnmap("<leader>gci", "<Plug>kommentary_motion_increase", {})
xnmap("<leader>gci", "<Plug>kommentary_visual_increase", {})
nnmap("<leader>gcdc", "<Plug>kommentary_line_decrease", {})
nnmap("<leader>gcd", "<Plug>kommentary_motion_decrease", {})
xnmap("<leader>gcd", "<Plug>kommentary_visual_decrease", {})

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
