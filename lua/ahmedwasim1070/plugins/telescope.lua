local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")

-- Custom function to switch to Normal Mode
local function stop_insert()
	vim.cmd.stopinsert()
end

telescope.setup({
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },

		-- === THE FIX: IGNORE JUNK FILES ===
		file_ignore_patterns = {
			-- MERN / JS
			"node_modules",
			"package%-lock.json",
			"yarn.lock",
			"dist",
			"build",
			".next",

			-- Python
			"__pycache__",
			"venv",
			".venv",
			"%.pyc",

			-- C++ / C# / Go / Compiled
			"bin",
			"obj",
			"vendor",
			"%.out",
			"%.exe",
			"%.o",
			"%.a",
			"%.dll",
			"%.so",

			-- General / Git
			".git/",
			".cache",
			".DS_Store",
			".vscode",
			".idea",
		},

		mappings = {
			i = {
				-- THE FIX: Tab stops typing and lets you navigate with j/k
				["<Tab>"] = stop_insert,

				-- Bonus: Use Ctrl+j/k to move while STILL typing (Faster!)
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,

				-- Keep Esc to Close (Quick Quit)
				["<Esc>"] = actions.close,
			},
			n = {
				-- Normal Mode Mappings (reached by pressing Tab)
				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["q"] = actions.close,
				["<Esc>"] = actions.close,
			},
		},

		-- Keep this to prevent the "TS" crash we fixed earlier
		preview = {
			treesitter = false,
		},
	},
	pickers = {
		find_files = {
			theme = "dropdown",
			hidden = true, -- Still find hidden files (like .env), just not ignored ones
		},
	},
})
