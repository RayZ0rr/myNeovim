local map = require('config/options/utils').map
local nnmap = require('config/options/utils').nnmap
local inmap = require('config/options/utils').inmap
local xnmap = require('config/options/utils').xnmap
local root_dir = require('config/options/utils').root_dir

local fzf_lua = require 'fzf-lua'
local actions = fzf_lua.actions
local utils = fzf_lua.utils

-- Files -------------------------------------------
nnmap('<C-p>', function() fzf_lua.files() end, {desc="Fzf-Lua files search pwd"})
nnmap('<Leader><C-p>', function() fzf_lua.files({no_ignore = true}) end, {desc="Fzf-Lua files search pwd all"})
nnmap('<leader>fa', function() fzf_lua.files({cwd='~'}) end, {desc="Fzf-Lua files search home"})
nnmap('<leader>fA', function() fzf_lua.files({cwd='~', no_ignore = true}) end, {desc="Fzf-Lua files search home all"})
nnmap('<leader>fp', function() fzf_lua.files({cwd = root_dir()}) end, {desc="Fzf-Lua files search project"})
nnmap('<leader>fP', function() fzf_lua.files({cwd = root_dir(), no_ignore = true}) end, {desc="Fzf-Lua files search project all"})
nnmap('<leader>fn', function() fzf_lua.files({cwd = '~/.config/nvim'}) end, {desc="Fzf-Lua files search nvim"})
nnmap('<space><space>', function() fzf_lua.buffers() end, {desc="Fzf-Lua buffers"})
nnmap('<leader>fo', function() fzf_lua.oldfiles() end, {desc="Fzf-Lua files search old"})
nnmap('<leader>fO', function() fzf_lua.oldfiles({cwd = vim.uv.cwd(), cwd_only = true}) end, {desc="Fzf-Lua files search old cwd"})
-- nnmap(
--   '<leader>fO',
--   function()
--     fzf_lua.oldfiles({
--     cwd_only = function()
--       return vim.api.nvim_command('pwd') ~= vim.env.HOME
--     end
--     })
--   end,
--   {desc="Fzf-Lua files search old current dir"}
-- )

-- Grep -------------------------------------------
local fzf_project_grep = fzf_lua.grep_project
nnmap('<leader>gg', function() fzf_lua.live_grep({exec_empty_query = true}) end, {desc="Fzf-Lua live grep"})
nnmap('<leader>g/', function() fzf_lua.grep_curbuf({search=""}) end, {desc="Fzf-Lua live grep buffer"})
nnmap('<leader>gw', function() fzf_project_grep({search = utils.input('Grep For❯ ')}) end, {desc="Fzf-Lua grep"})
nnmap('<leader>gW', function() fzf_project_grep({search = utils.input('Grep For❯ '), no_ignore = true}) end, {desc="Fzf-Lua grep all"})
nnmap('<leader>gr', function() fzf_project_grep({continue_last_search = true}) end, {desc="Fzf-Lua grep continue last"})
xnmap('<leader>gw', function() fzf_project_grep({search = utils.get_visual_selection()}) end, {desc="Fzf-Lua grep visual"})
xnmap('<leader>gW', function() fzf_project_grep({search = utils.get_visual_selection(), no_ignore = true}) end, {desc="Fzf-Lua grep visual all"})
nnmap('<leader>gp', function() fzf_project_grep({search = utils.input('Grep For❯ '), cwd = root_dir()}) end, {desc="Fzf-Lua grep project"})
nnmap('<leader>gP', function() fzf_project_grep({search = utils.input('Grep For❯ '), cwd = root_dir(), no_ignore = true}) end, {desc="Fzf-Lua grep project"})
xnmap('<leader>gp', function() fzf_project_grep({search = utils.get_visual_selection(), cwd = root_dir()}) end, {desc="Fzf-Lua grep project visual"})
xnmap('<leader>gP', function() fzf_project_grep({search = utils.get_visual_selection(), cwd = root_dir(), no_ignore = true}) end, {desc="Fzf-Lua grep project visual all"})

-- LSP -------------------------------------------
nnmap("<leader>ll", function() fzf_lua.lsp_finder() end, {desc = "LSP Finder"})
nnmap("<leader>ld", function() fzf_lua.lsp_definitions() end, {desc = "Goto Definition"})
nnmap("<leader>lD", function() fzf_lua.lsp_declarations() end, {desc = "Goto Declaration"})
nnmap("<leader>lr", function() fzf_lua.lsp_references() end, {nowait = true, desc = "References"})
nnmap("<leader>li", function() fzf_lua.lsp_implementations() end, {desc = "Goto Implementation"})
nnmap("<leader>lt", function() fzf_lua.lsp_type_definitions() end, {desc = "Goto Type Definition"})
nnmap("<leader>ls", function() fzf_lua.lsp_document_symbols() end, {desc = "LSP Symbols (buffer)"})
nnmap("<leader>lS", function() fzf_lua.lsp_workspace_symbols() end, {desc = "LSP Symbols (workspace)"})
nnmap("<leader>la", function() fzf_lua.lsp_code_actions() end, {desc = "Code Actions"})
nnmap("<leader>fe", function() fzf_lua.diagnostics_document() end, {desc = "Buffer Diagnostics"})
nnmap("<leader>fE", function() fzf_lua.diagnostics_workspace() end, {desc = "Workspace Diagnostics"})

-- Misc -------------------------------------------
nnmap('<leader>fg', function() fzf_lua.git_files() end, {desc="Fzf-Lua git files"})
nnmap('<leader>fd', function() fzf_lua.git_bcommits() end, {desc="Fzf-Lua git commits buffer"})
nnmap('<leader>flb', function() fzf_lua.blines() end, {desc="Fzf-Lua buffer lines"})
nnmap('<leader>fll', function() fzf_lua.lines() end, {desc="Fzf-Lua lines"})
nnmap('<F1>', function() fzf_lua.help_tags() end, {desc="Fzf-Lua help tags"})
nnmap('<leader>fh', function() fzf_lua.man_pages() end, {desc="Fzf-Lua man pages"})
nnmap('<leader>fm', function() fzf_lua.marks() end, {desc="Fzf-Lua marks"})
map({'n', 'x',}, '<leader>fr', function() fzf_lua.registers() end, {desc="Fzf-Lua registers"})
nnmap('<leader>f:', function() fzf_lua.command_history() end, {desc="Fzf-Lua command history"})
nnmap('<leader>f/', function() fzf_lua.search_history() end, {desc="Fzf-Lua search history"})
nnmap("<leader>ft", function() fzf_lua.treesitter() end, {desc = "Fzf-Lua Treesitter"})
nnmap('<leader>fq', function() fzf_lua.quickfix() end, {desc="Fzf-Lua quickfix"})
nnmap('<leader>fQ', function() fzf_lua.quickfix_stack() end, {desc="Fzf-Lua quickfix stack"})
nnmap(
    -- This is the default nvim binding, which I am overriding here.
    'z=',
    function()
        fzf_lua.spell_suggest {
            winopts = {
                relative = 'cursor',
                row = 1.01,
                col = 0,
                width = 0.2,
                height = 0.2,
            },
        }
    end,
    {desc = 'Fzf-Lua Spelling suggestions (Overriden default z=)'}
)
