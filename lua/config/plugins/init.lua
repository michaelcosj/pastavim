------[[ Plugin Manager (packer) ]]------

-- Automatically install packer
local fn = vim.fn
local packer_bootstrap = false

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

--- Autocommand to install/update plugins on file save
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost */config/plugins/*.lua source <afile> | PackerCompile
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Safely require packer
local ok, packer = pcall(require, "packer")
if not ok then
	return
end

-- Safely call impatient to speed up loading plugins
pcall(require, "impatient")

-- set colourscheme
require("config.plugins.colourscheme")

-- Initialize LSP handler
require("config.plugins.lsp.handler").init()

return packer.startup({
	function(use)
		-- Plugin Manager manages itself
		---- https://github.com/wbthomason/packer.nvim
		use("wbthomason/packer.nvim")

		local plugins = require("config.plugins.plugins")

		use(plugins)

		-- Required to autoinstall packer
		if packer_bootstrap then
			require("packer").sync()
		end
	end,

	config = {
		display = {
			open_fn = function()
				-- Display in a popup window
				return require("packer.util").float({ border = "rounded" })
			end,
			prompt_border = "rounded",
		},
		profile = {
			-- Enable profiling
			enable = true,
			threshold = 1,
		},
	},
})
