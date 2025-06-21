require("nvim-treesitter.configs").setup({
	-- Parsers for MERN stack, Python, Go, C/C++, and Java
	ensure_installed = {
		-- MERN Stack
		"javascript",
		"typescript",
		"tsx",
		"html",
		"css",
		"scss",
		"json",
		"yaml",
		"toml",
		"markdown",
		"markdown_inline",

		-- Backend & Database
		"python",
		"go",
		"sql",

		-- Systems Programming
		"c",
		"cpp",
		"java",

		-- Configuration & Utility
		"lua",
		"vim",
		"vimdoc",
		"bash",
		"dockerfile",
		"gitignore",
		"gitcommit",
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	auto_install = true,

	-- List of parsers to ignore installing (for "all")
	ignore_install = {},

	highlight = {
		enable = true,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		additional_vim_regex_highlighting = false,

		-- Disable highlighting for large files
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
	},

	indent = {
		enable = true,
		-- Disable indentation for specific languages if problematic
		disable = { "python" }, -- Python indentation can be tricky with treesitter
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
})

-- Set up folding based on treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false -- Disable folding at startup

-- Additional filetype associations for better recognition
vim.filetype.add({
	extension = {
		env = "sh",
		envrc = "sh",
		eslintrc = "json",
		prettierrc = "json",
		tsconfig = "json",
	},
	filename = {
		[".eslintrc"] = "json",
		[".prettierrc"] = "json",
		[".babelrc"] = "json",
		["tsconfig.json"] = "json",
		["package.json"] = "json",
		[".env"] = "sh",
		[".envrc"] = "sh",
		["Dockerfile"] = "dockerfile",
		["docker-compose.yml"] = "yaml",
		["docker-compose.yaml"] = "yaml",
	},
	pattern = {
		["%.env%..*"] = "sh",
		[".*%.component%.ts"] = "typescript",
		[".*%.service%.ts"] = "typescript",
		[".*%.module%.ts"] = "typescript",
		[".*%.spec%.ts"] = "typescript",
		[".*%.test%.ts"] = "typescript",
		[".*%.spec%.js"] = "javascript",
		[".*%.test%.js"] = "javascript",
	},
})
