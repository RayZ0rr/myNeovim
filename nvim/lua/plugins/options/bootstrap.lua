-- ########################################################
-- Bootstrap ( Check if "packer.nvim" exists or not )
-- ########################################################

-- If you want to automatically ensure that packer.nvim is installed on any machine you clone your configuration to,
-- add the following snippet (which is due to @Iron-E) somewhere in your config before your first usage of packer:
-- local fn = vim.fn
-- local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
-- if fn.empty(fn.glob(install_path)) > 0 then
--   print "Cloning packer .."

--   fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }

--   print "Packer cloned successfully!"

--   -- install plugins + compile their configs
--   vim.cmd "packadd packer.nvim"
--   require "plugins/options/pluginsList"
--   vim.cmd "PackerSync"
-- end

local M = {}

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

M.packer_bootstrap = ensure_packer()

_G.myLazyLoad = function(plugin, timer)
  if plugin then
    timer = timer or 0
    vim.defer_fn(function()
      require("packer").loader(plugin)
    end, timer)
  end
end

-- don't throw any error on first use by packer
local ok, packer = pcall(require, "packer")
if ok then

  local PackerGroup = vim.api.nvim_create_augroup('PackerGroup', { clear = true })
  vim.api.nvim_create_autocmd('BufWritePost', { command = 'source <afile> | PackerCompile', group = PackerGroup, pattern = 'init.lua' })
  vim.api.nvim_create_autocmd('BufWritePost', { command = 'source <afile> | PackerSync', group = PackerGroup, pattern = 'pluginsList.lua' })

  packer.init {
    auto_clean = true,
    compile_on_sync = true,
--  compile_path = vim.fn.stdpath("config") .. "/autoload/packer_compiled.lua",
    git = { clone_timeout = 6000 },
    profile = {
      enable = true,
      threshold = 1 -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
    display = {
      working_sym = "ﲊ",
      error_sym = "✗",
      done_sym = "﫟",
      removed_sym = "",
      moved_sym = "",
      open_fn = function()
	return require("packer.util").float { border = "rounded" }
      end,
    },
  }

end

return M
