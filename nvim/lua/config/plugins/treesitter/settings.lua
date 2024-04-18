-- Treesitter configuration
vim.opt.foldmethod='expr'
vim.cmd[[set foldexpr=nvim_treesitter#foldexpr()]]
vim.opt.foldlevel=99

-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "c",
    "cpp",
    "python",
    "bash",
    "lua",
    "rust",
    "html",
    "css",
    "toml",
    "vim",
    -- for `nvim-treesitter/playground`
    "query",
  },
  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,
  highlight = {
    enable = true, -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      -- init_selection = 'gnn',
      init_selection = '<cr>',
      node_incremental = '<tab>',
      scope_incremental = 'grc',
      node_decremental = '<s-tab>',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['ao'] = '@class.outer',
        ['io'] = '@class.inner',
        ["af"] = "@function.outer"   ,
        ["if"] = "@function.inner"   ,
        ["agc"] = "@comment.outer",
        -- ["igc"] = "@comment.inner",
        ["ab"] = "@block.outer"      ,
        ["ib"] = "@block.inner"      ,
        ["<leader>ac"] = "@call.outer"       ,
        ["<leader>ic"] = "@call.inner"       ,
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["al"] = "@loop.outer"       ,
        ["il"] = "@loop.inner"       ,
        -- ["an"] = "@scopename.outer"  ,
        ["in"] = "@scopename.inner"  ,
        ["as"] = "@statement.outer"  ,
        -- ["is"] = "@statement.inner"  ,

      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>tss"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>tsS"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    lsp_interop = {
      enable = true,
      border = 'rounded',
      peek_definition_code = {
        ["<leader>tsd"] = "@function.outer",
        ["<leader>tsD"] = "@class.outer",
      },
    },
  },
}

local ok_ts_context, _ = pcall(require, 'ts_context_commentstring')
if ok_ts_context then
    vim.g.skip_ts_context_commentstring_module = true
    require('ts_context_commentstring').setup {}
end
