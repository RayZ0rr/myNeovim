local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")
if not ok then
  print('[Error] (bootstrap.lua): lazy.nvim not found. Skipping loading of plugins.')
  return
end
-- local LazyGroup = vim.api.nvim_create_augroup('LazyGroup', { clear = true })
-- vim.api.nvim_create_autocmd('BufWritePost', { command = 'source <afile> | Lazy sync', group = LazyGroup, pattern = 'pluginsList.lua' })
