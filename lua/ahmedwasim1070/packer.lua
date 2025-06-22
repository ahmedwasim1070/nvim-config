-- ~/.config/nvim/lua/ahmedwasim1070/packer.lua

-- Auto-install Packer if not present
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({
			"git",
			"clone",
			"--depth",
			"1",
			"https://github.com/wbthomason/packer.nvim",
			install_path,
		})
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Auto-reload when saving this file
vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

-- Plugins
return require("packer").startup(function(use)
	use("wbthomason/packer.nvim") -- Packer manages itself

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	-- Bufferline
	use({ "akinsho/bufferline.nvim", tag = "*", requires = "nvim-tree/nvim-web-devicons" })

	--  Theme
	use({
		"nyoom-engineering/oxocarbon.nvim",
		config = function()
			-- Optional: Configure the theme
			vim.opt.background = "dark" -- or "light" for light mode

			-- Set the colorscheme
			vim.cmd("colorscheme oxocarbon")
		end,
	})

	--  Lualine
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	--  Nvimtree
	use({
		"nvim-tree/nvim-tree.lua",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-tree").setup({})
		end,
	})

	-- prettier
	use({
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
				formatters_by_ft = {
					javascript = { "prettier" },
					typescript = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					json = { "prettier" },
					markdown = { "prettier" },
					lua = { "stylua" },
					python = { "black" },
					sh = { "shfmt" },
					go = { "gofmt" },
					cpp = { "clang_format" },
					c = { "clang_format" },
					java = { "clang_format" },
				},
			})
		end,
	})

	-- LSP Support (no Mason)
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})

	-- Automatically set up config after cloning packer.nvim
	if packer_bootstrap then
		require("packer").sync()
	end
end)
