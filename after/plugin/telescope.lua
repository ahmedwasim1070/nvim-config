-- ~/.config/nvim/after/plugin/telescope.lua

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

telescope.setup({
	defaults = {
		prompt_prefix = "🔍 ",
		selection_caret = " ",
		path_display = { "smart" },
		layout_config = {
			horizontal = { width = 0.9 },
		},
		file_ignore_patterns = { "node_modules", ".git/" },
	},
	pickers = {
		find_files = {
			hidden = true,
		},
		live_grep = {
			only_sort_text = true,
		},
		buffers = {
			sort_mru = true,
		},
	},
})

-- Optional: Load Telescope extensions here if needed
-- require("telescope").load_extension("fzf")  -- if you install fzf-native
