local M = {}

function M.setup()
	-- 1. Try to load Oxocarbon safely
	local status_ok, _ = pcall(vim.cmd, "colorscheme oxocarbon")
	if not status_ok then
		vim.notify("Oxocarbon theme not found!", vim.log.levels.ERROR)
		return
	end

	-- 2. ENABLE TRUE TRANSPARENCY (The "Ghost" Mode)
	-- We iterate through all major UI elements and force their background to NONE.
	local highlights = {
		"Normal", -- Main Window
		"NormalNC", -- Inactive Window
		"SignColumn", -- Gutter (Line Numbers)
		"FoldColumn", -- Code Folding area
		"StatusLine", -- Status Line
		"StatusLineNC",
		"VertSplit", -- Vertical Split line
		"NvimTreeNormal", -- File Explorer Background
		"NvimTreeNormalNC",
		"EndOfBuffer", -- The "~" symbols at end of file
		"MsgArea", -- Command line area
	}

	for _, name in pairs(highlights) do
		vim.api.nvim_set_hl(0, name, { bg = "none" })
	end

	-- Optional: Make float windows transparent too (Popups/LSP)
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return M
