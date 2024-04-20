local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")
if not ok then
  vim.cmd("echom '[Error] (bootstrap.lua): Could not download lazy.nvim. Lazy will not be loaded.'")
  return
end
-- local LazyGroup = vim.api.nvim_create_augroup('LazyGroup', { clear = true })
-- vim.api.nvim_create_autocmd('BufWritePost', { command = 'source <afile> | Lazy sync', group = LazyGroup, pattern = 'pluginsList.lua' })
