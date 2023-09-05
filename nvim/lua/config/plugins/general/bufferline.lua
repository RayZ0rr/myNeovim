
local nnmap = require('config/options/utils').nnmap
local inmap = require('config/options/utils').inmap

-- snnmap('<S-x>', ':BufferClose<CR>')

--These commands will move the current buffer backwards or forwards in the bufferline
nnmap('<leader><TAB>',':BufferLineMoveNext<CR>')
nnmap('<leader><S-TAB>',':BufferLineMovePrev<CR>')

-- These commands will navigate through buffers in order regardless of which mode you are using
-- e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
nnmap('<M-a>',':BufferLineCyclePrev<CR>')
nnmap('<M-s>',':BufferLineCycleNext<CR>')
inmap('<M-a>','<esc>:BufferLineCyclePrev<CR>')
inmap('<M-s>','<esc>:BufferLineCycleNext<CR>')

nnmap('<leader>bfp', ':BufferLinePick<CR>')

--These commands will sort buffers by directory, language, or a custom criteria
nnmap('<leader>bfe',':BufferLineSortByExtension<CR>')
nnmap('<leader>bfd',':BufferLineSortByDirectory<CR>')
nnmap('<leader>bfn', ":lua require('bufferline').sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>" )

-- require("bufferline").setup{}
require('bufferline').setup {
  options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    -- For ⁸·₂
    numbers = function(opts)
      return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
    end,
    -- numbers = "both",  --	"none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    -- number_style = "", -- buffer_id at index 1, ordinal at index 2
    close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
    right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    indicator = {
      style = 'icon',
      icon = '▎', -- this should be omitted if indicator style is not 'icon'
    },
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',

    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      if context.buffer:current() then
        return ''
      end
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    offsets = {
      {filetype = "fern", text = "File Explorer", text_align = "center"},
      {filetype = "undotree", text = "Undo Timeline", text_align = "center"},
      {filetype = "vim-plug", text = "Plugin Manager", text_align = "center"},
      {filetype = "NvimTree", text = "File Explorer", text_align = "center"},
    },
    color_icons = true, -- whether or not to add the filetype icon highlights
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "padded_slant", -- "slant" | "thick" | "thin" | { 'any', 'any' },
    -- separator_style = "thick",
    -- padded_slant = 10 ,
    -- enforce_regular_tabs = false | true,
    always_show_bufferline = true,
    -- 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
    sort_by = 'id'
    -- function(buffer_a, buffer_b)
    --     -- add custom logic
    --  		return buffer_a.modified > buffer_b.modified
    -- end
  }
}
