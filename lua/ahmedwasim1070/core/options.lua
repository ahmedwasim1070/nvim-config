local opt = vim.opt

-- GPU Acceleration / Colors
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.background = "dark"
opt.termguicolors = true
opt.cursorline = true
opt.scrolloff = 8

-- Indentation
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Size of an indent
opt.tabstop = 2 -- Number of spaces tabs count for
opt.softtabstop = 2
opt.smartindent = true -- Insert indents automatically

-- UI Tweaks
opt.number = true -- Show line numbers
opt.relativenumber = false -- Keep them static (don't change with cursor)
opt.numberwidth = 4 -- Give the numbers some breathing room
opt.cursorline = true -- Highlight current line
opt.splitbelow = true -- Force horizontal splits to go below
opt.splitright = true -- Force vertical splits to go right
opt.scrolloff = 8 -- Keep 8 lines above/below cursor

-- Netrw Defaults
vim.g.netrw_banner = 0 -- Removes Default Guide Lines
vim.g.netrw_liststyle = 3 -- Tree View

-- =========================================
-- CLEAN STATUSLINE FOR NVIM-TREE (Fixed)
-- =========================================
vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
	pattern = "*", -- Runs on all windows, but we check specific conditions below
	callback = function()
		-- Only run this if we are actually in the NvimTree window
		if vim.bo.filetype == "NvimTree" then
			-- 1. Force the Statusline text
			vim.opt_local.statusline = "%#Normal# NVIM "

			-- 2. Hide the ruler (10/50)
			vim.opt_local.ruler = false

			-- 3. Ensure cursorline is on
			vim.opt_local.cursorline = true
		end
	end,
})
