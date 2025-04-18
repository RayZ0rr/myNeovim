local has_cmp, cmp = pcall(require, 'cmp')
if not has_cmp then
  return
end

local luasnip = require("luasnip")

-- lsp-kind alternative
local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

local function get_kind(kind_item)
  local prsnt, lspkind = pcall(require, "lspkind")
  if not prsnt then
    return kind_icons[kind_item]
  else
    return lspkind.presets.default[kind_item]
  end
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Set completeopt to have a better completion experience
vim.opt.completeopt = { "menu", "menuone", "noselect" }

cmp.setup({
  completion = {
    keyword_length  = 3,
  },
  view = {
    entries = "custom" -- can be "custom", "wildmenu" or "native"
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping({
       i = function(fallback)
         if cmp.visible() and cmp.get_active_entry() then
           cmp.confirm({ behavior = cmp.ConfirmBehavior.Select, select = true })
         else
           fallback()
         end
       end,
       s = cmp.mapping.confirm({ select = true }),
     }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    }, {
      { name = 'buffer' },
      { name = 'path' },
  }),

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({'/', '?'}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  }),

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
      }, {
        { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  }),

  formatting = {
    format = function(entry, vim_item)
      local prsnt, lspkind = pcall(require, "lspkind")
      if not prsnt then
        -- Kind icons
        vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
        -- Source
        vim_item.menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[Lua]",
          latex_symbols = "[LaTeX]",
        })[entry.source.name]
        return vim_item
      else
        return lspkind.cmp_format({
            mode = "symbol_text",
            menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[Latex]",
            })
        })(entry, vim_item)
      end
    end
  },
})

-- vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg='NONE', fg='#ff4444' })
-- vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link='CmpIntemAbbrMatch' })

require("luasnip.loaders.from_vscode").lazy_load()

local LuasnipPrev = function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end
local LuasnipNext = function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end
vim.keymap.set({"i","s"},"<m-h>",LuasnipPrev,{desc="Luasnip choose previous node function"})
vim.keymap.set({"i","s"},"<m-l>",LuasnipNext,{desc="Luasnip choose next node function"})
