local api = vim.api

local CPPEnhanceGroup = api.nvim_create_augroup("CPPEnhanceGroup", { clear = true })
api.nvim_create_autocmd(
  { "BufNewFile" },
  { pattern = {"*.cpp","*.cc"}, command = [[0put =\"// -*- C++ -*-\<nl>\"|$]], group = CPPEnhanceGroup }
)
api.nvim_create_autocmd(
  { "BufNewFile" },
  { pattern = {"*.hpp","*.hh"}, command = [[0put =\"// -*- C++ Header -*-\<nl>\"|$]], group = CPPEnhanceGroup }
)

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

