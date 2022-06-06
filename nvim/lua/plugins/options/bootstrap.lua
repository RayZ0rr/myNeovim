-- ########################################################
-- Bootstrap ( Check if "packer.nvim" exists or not )
-- ########################################################

-- If you want to automatically ensure that packer.nvim is installed on any machine you clone your configuration to,
-- add the following snippet (which is due to @Iron-E) somewhere in your config before your first usage of packer:
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	print "Cloning packer .."

	fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }

	print "Packer cloned successfully!"

	-- install plugins + compile their configs
	vim.cmd "packadd packer.nvim"
	require "plugins/options/pluginsList"
	vim.cmd "PackerSync"
end

_G.myLazyLoad = function(plugin, timer)
	if plugin then
		timer = timer or 0
		vim.defer_fn(function()
			require("packer").loader(plugin)
		end, timer)
	end
end
