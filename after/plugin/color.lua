function ColorMyPencil(color)
	color = color or "oxocarbon"
	vim.cmd.colorscheme(color)

	-- Make editor background transparent
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

	-- Make line numbers transparent
	vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
	vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

	-- NvimTree
	vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#000000" }) -- Main tree background
	vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "#000000" }) -- When it's not focused
	vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { fg = "#000000" }) -- Hide ~ symbols at bottom

	-- Bufferline - Clean Design with True Transparency
	-- Main fill (background behind tabs) - fully transparent
	vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#000000" })
	vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "#000000" })

	-- Active/Selected tab - has background color
	vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { fg = "#f3f3f3", bg = "#1e1e1e", bold = true })
	vim.api.nvim_set_hl(0, "BufferLineNumbersSelected", { fg = "#888888", bg = "#1e1e1e" })
	vim.api.nvim_set_hl(0, "BufferLineDevIconSelected", { bg = "#1e1e1e" })
	vim.api.nvim_set_hl(0, "BufferLineCloseButtonSelected", { fg = "#ffffff", bg = "#1e1e1e" })
	vim.api.nvim_set_hl(0, "BufferLineModifiedSelected", { fg = "#ffaa00", bg = "#1e1e1e" })
	vim.api.nvim_set_hl(0, "BufferLineDuplicateSelected", { fg = "#888888", bg = "#1e1e1e" })
	vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected", { fg = "#1e1e1e", bg = "NONE" })

	-- Inactive/Background tabs - fully transparent
	vim.api.nvim_set_hl(0, "BufferLineBuffer", { fg = "#666666", bg = "NONE" })
	vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { fg = "#666666", bg = "NONE" })
	vim.api.nvim_set_hl(0, "BufferLineNumbers", { fg = "#444444", bg = "NONE" })
	vim.api.nvim_set_hl(0, "BufferLineNumbersVisible", { fg = "#666666", bg = "NONE" })
	vim.api.nvim_set_hl(0, "BufferLineDevIcon", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "BufferLineDevIconVisible", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "BufferLineCloseButton", { fg = "#444444", bg = "NONE" })
	vim.api.nvim_set_hl(0, "BufferLineCloseButtonVisible", { fg = "#666666", bg = "NONE" })
	vim.api.nvim_set_hl(0, "BufferLineModified", { fg = "#ffaa00", bg = "NONE" })
	vim.api.nvim_set_hl(0, "BufferLineModifiedVisible", { fg = "#ffaa00", bg = "NONE" })
	vim.api.nvim_set_hl(0, "BufferLineDuplicate", { fg = "#666666", bg = "NONE" })
	vim.api.nvim_set_hl(0, "BufferLineDuplicateVisible", { fg = "#666666", bg = "NONE" })
	vim.api.nvim_set_hl(0, "BufferLineSeparator", { fg = "NONE", bg = "NONE" })
	vim.api.nvim_set_hl(0, "BufferLineSeparatorVisible", { fg = "NONE", bg = "NONE" })

	-- Additional groups that might have backgrounds
	vim.api.nvim_set_hl(0, "BufferLineBackground", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "BufferLineIndicatorVisible", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "BufferLineIndicator", { bg = "NONE" })

	-- Tab mode (if using tabs)
	vim.api.nvim_set_hl(0, "BufferLineTabSelected", { fg = "#ffffff", bg = "#1e1e1e", bold = true })
	vim.api.nvim_set_hl(0, "BufferLineTab", { fg = "#666666", bg = "none" })
	vim.api.nvim_set_hl(0, "BufferLineTabClose", { fg = "#666666", bg = "none" })

	-- Diagnostic icons - match their respective tab backgrounds
	vim.api.nvim_set_hl(0, "BufferLineError", { fg = "#ff5555", bg = "none" })
	vim.api.nvim_set_hl(0, "BufferLineErrorSelected", { fg = "#ff5555", bg = "#1e1e1e" })
	vim.api.nvim_set_hl(0, "BufferLineErrorVisible", { fg = "#ff5555", bg = "none" })
	vim.api.nvim_set_hl(0, "BufferLineWarning", { fg = "#ffaa00", bg = "none" })
	vim.api.nvim_set_hl(0, "BufferLineWarningSelected", { fg = "#ffaa00", bg = "#1e1e1e" })
	vim.api.nvim_set_hl(0, "BufferLineWarningVisible", { fg = "#ffaa00", bg = "none" })
	vim.api.nvim_set_hl(0, "BufferLineHint", { fg = "#00dfff", bg = "none" })
	vim.api.nvim_set_hl(0, "BufferLineHintSelected", { fg = "#00dfff", bg = "#1e1e1e" })
	vim.api.nvim_set_hl(0, "BufferLineHintVisible", { fg = "#00dfff", bg = "none" })
	vim.api.nvim_set_hl(0, "BufferLineInfo", { fg = "#55ffff", bg = "none" })
	vim.api.nvim_set_hl(0, "BufferLineInfoSelected", { fg = "#55ffff", bg = "#1e1e1e" })
	vim.api.nvim_set_hl(0, "BufferLineInfoVisible", { fg = "#55ffff", bg = "none" })
end

ColorMyPencil()
