local fn = vim.fn

-- For Packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
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

-- Validate Error
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Packer PopUp
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Plugins/ Packer AutoSync
return packer.startup(function(use)
	-- Plugings
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim") -- Vital dependancy
	use("nvim-tree/nvim-web-devicons") -- Web Dev - Icons
	use("lewis6991/gitsigns.nvim") -- For Git Branch
	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x", -- Telescope - File Finder
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({
		"nvim-tree/nvim-tree.lua", -- Nvim Tree - Tree
		requires = {
			"nvim-tree/nvim-web-devicons", -- Web Dev - Icons
		},
	})
	-- Syntax Highlighting
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	-- LSP
	use({ "neovim/nvim-lspconfig", tag = "v0.1.8" })
	use("williamboman/mason.nvim") -- Installer for LSPs/Formatters
	use("williamboman/mason-lspconfig.nvim") -- Bridges Mason and LSPConfig
	-- Formatting & Linting
	use("nvimtools/none-ls.nvim") -- (Formerly null-ls) formatting/linting
	use("jay-babu/mason-null-ls.nvim") -- Installs formatters via Mason
	-- Auto-Completion
	use("hrsh7th/nvim-cmp") -- The Core Completion Engine
	use("hrsh7th/cmp-buffer") -- Suggest words from current buffer
	use("hrsh7th/cmp-path") -- Suggest file paths
	use("hrsh7th/cmp-nvim-lsp") -- Suggest variables from LSP
	use("saadparwaiz1/cmp_luasnip") -- Snippet source
	use("L3MON4D3/LuaSnip") -- Snippet engine (Required for cmp)

	-- Themes
	use("nyoom-engineering/oxocarbon.nvim")

	-- Packer Sync
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
