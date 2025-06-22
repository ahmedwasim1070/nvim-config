require("bufferline").setup({
	options = {
		-- Enable LSP diagnostics integration (shows errors/warnings in tabs)
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = false,

		-- Custom diagnostic indicator with icons
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,

		-- Left click to switch to buffer
		left_mouse_command = "buffer %d",
		-- Right click to close buffer
		right_mouse_command = "bdelete! %d",
		-- Disable middle mouse click
		middle_mouse_command = nil,

		-- Icons for different states
		buffer_close_icon = "󰅖",
		modified_icon = "●",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",

		separator_style = "thin",

		-- Show buffer numbers for easy navigation (1, 2, 3, etc.)
		numbers = "none",

		-- Close command when clicking close button
		close_command = "bdelete! %d",

		-- Always show bufferline (even with single buffer)
		always_show_bufferline = true,

		-- Show close buttons on tabs
		show_buffer_close_icons = false,
		show_close_icon = false,

		-- Show file type icons with colors
		show_buffer_icons = true,
		color_icons = true,

		-- Enforce consistent tab sizes
		enforce_regular_tabs = false,

		-- Handle duplicate file names by showing path
		show_duplicate_prefix = true,

		-- Tab and name length limits
		max_name_length = 20,
		max_prefix_length = 16,
		truncate_names = true,
		tab_size = 20,

		-- Buffer sorting method
		sort_by = "insert_after_current",

		-- Filter out special buffers (quickfix, help, etc.)
		custom_filter = function(buf_number, buf_numbers)
			local filetype = vim.bo[buf_number].filetype
			-- Hide quickfix and help buffers from bufferline
			if filetype == "qf" or filetype == "help" or filetype == "alpha" then
				return false
			end
			return true
		end,

		-- Create space for file explorers on the left
		offsets = {
			{
				filetype = "NvimTree",
				text = "Neovim",
				text_align = "center",
				separator = true,
				padding = 1,
			},
			{
				filetype = "neo-tree",
				text = "Neo-tree",
				text_align = "center",
				separator = true,
				padding = 1,
			},
			{
				filetype = "alpha",
				text = "Dashboard",
				text_align = "center",
				separator = true,
				padding = 1,
			},
		},
	},
})
