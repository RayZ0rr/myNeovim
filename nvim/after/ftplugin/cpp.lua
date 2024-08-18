-- if vim.b.did_ftplugin == 1 then
--   return
-- end
-- vim.b.did_ftplugin = 1

vim.bo.commentstring = "// %s"

local has_luasnip, luasnip = pcall(require, 'luasnip')
if has_luasnip then
    local lss = luasnip.snippet
    local lsn = luasnip.snippet_node
    local lst = luasnip.text_node
    local lsi = luasnip.insert_node
    local lsin = luasnip.indent_snippet_node
    luasnip.add_snippets("cpp", {
        lss("setupmain", {
            lst({"#include <iostream>"}),
            lst({"", "#include <string>"}),
            lst({"", "#include <vector>"}),
            lst({"", "#include <memory>"}),
            lst({"",""}),
            lst({"", "int main(int argc, char* argv[])"}),
            lst({"", "{"}),
            lst({"",""}),
            -- lst({"","  "}), lsi(0),
            -- lsin(1, lst({"//This is", "A multiline", "comment"}), "$PARENT_INDENT//","test"),lsi(0),
            lsin(1, lst({"",""}),"","//"),lsi(0),
            lst({"",""}),
            lst({"", "}"})
        })
    })
end

local CPPEnhanceGroup = vim.api.nvim_create_augroup("CPPEnhanceGroup", { clear = true })
vim.api.nvim_create_autocmd(
    { "BufWritePre" },
    {
        pattern = {"*.cpp","*.cc", "*.cxx"},
        callback = function()
            local line1 = vim.api.nvim_buf_get_lines(0, 0, 1, true)[1]
            local has_header = line1:match("%-%*%- C%+%+ %-%*%-")
            if not has_header then
                vim.cmd([[0put =\"// -*- C++ -*-\<nl>\"|$]])
            end
        end,
        group = CPPEnhanceGroup,
        once = true,
    }
)
vim.api.nvim_create_autocmd(
    { "BufWritePre" },
    {
        pattern = {"*.hpp","*.hh", "*.h"},
        callback = function()
            local line1 = vim.api.nvim_buf_get_lines(0, 0, 1, true)[1]
            local has_header = line1:match("%-%*%- C%+%+ Header %-%*%-")
            if not has_header then
                vim.cmd([[0put =\"// -*- C++ Header -*-\<nl>\"|$]])
            end
        end,
        group = CPPEnhanceGroup,
        once = true,
    }
)
