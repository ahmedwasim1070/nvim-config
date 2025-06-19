-- Bufferline configuration for VS Code-style tabs
require('bufferline').setup {
  options = {
    -- Use nvim's native LSP for diagnostics
    diagnostics = "nvim_lsp",
    
    -- Show LSP diagnostics in bufferline
    diagnostics_update_in_insert = false,
    
    -- Diagnostic symbols
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,

    -- Clickable tabs
    left_mouse_command = "buffer %d",
    right_mouse_command = "bdelete! %d",
    middle_mouse_command = nil,

    -- Buffer close icon
    buffer_close_icon = '󰅖',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',

    -- VS Code style appearance
    separator_style = "thin", -- "slant" | "thick" | "thin" | { 'any', 'any' }
    
    -- Show buffer numbers for easier navigation
    numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | "both"
    
    -- Close command
    close_command = "bdelete! %d",
    
    -- Show only if more than one buffer
    always_show_bufferline = true,
    
    -- Show tab close button
    show_buffer_close_icons = true,
    show_close_icon = true,
    
    -- Enforce regular tabs
    enforce_regular_tabs = true,
    
    -- Show duplicate names with path
    show_duplicate_prefix = true,
    
    -- Truncate names
    max_name_length = 18,
    max_prefix_length = 15,
    truncate_names = true,
    
    -- Tab size
    tab_size = 20,
    
    -- Color icons
    color_icons = true,
    
    -- Show buffer icons
    show_buffer_icons = true,
    
    -- Hover functionality
    hover = {
      enabled = true,
      delay = 200,
      reveal = {'close'}
    },

    -- Sort buffers
    sort_by = 'insert_after_current', -- 'insert_after_current' | 'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs'

    -- Custom filter for special buffers
    custom_filter = function(buf_number, buf_numbers)
      -- Filter out certain filetypes
      local filetype = vim.bo[buf_number].filetype
      if filetype == "qf" or filetype == "help" then
        return false
      end
      return true
    end,

    -- Offsets for file explorers
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center", -- "left" | "center" | "right"
        separator = true
      },
      {
        filetype = "neo-tree",
        text = "Neo-tree",
        text_align = "center",
        separator = true
      }
    },
  },

  highlights = {
    -- VS Code-like styling
    buffer_selected = {
      bold = true,
      italic = true,
      fg="#000000";
    },
    
    -- Inactive buffer styling
    buffer_visible = {
      italic = false,
    },
    
    -- Close button styling
    close_button = {
      fg = '#999999',
    },
    
    close_button_visible = {
      fg = '#999999',
    },
    
    close_button_selected = {
      fg = '#ff5555',
    },
    
    -- Modified indicator
    modified_selected = {
      fg = '#ffaa00',
    },
    
    -- Separator styling for cleaner look
    separator = {
      fg = '#3c3836',
    },
    
    separator_selected = {
      fg = '#3c3836',
    },
    
    separator_visible = {
      fg = '#3c3836',
    },
  }
}

-- Commands for better buffer management
vim.api.nvim_create_user_command('BufferLineCloseAll', function()
  vim.cmd('BufferLineCloseLeft')
  vim.cmd('BufferLineCloseRight')
end, {})

-- Auto-command to show bufferline only when needed
vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
  pattern = "*",
  callback = function()
    local buf_count = #vim.fn.getbufinfo({buflisted = 1})
    if buf_count <= 1 then
      vim.opt.showtabline = 0
    else
      vim.opt.showtabline = 2
    end
  end,
})
