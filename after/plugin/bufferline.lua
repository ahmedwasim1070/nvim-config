require('bufferline').setup {
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
    buffer_close_icon = '󰅖',
    modified_icon = '●',   
    close_icon = '',      
    left_trunc_marker = '',
    right_trunc_marker = '',     
    
    separator_style = "thin",
    
    -- Show buffer numbers for easy navigation (1, 2, 3, etc.)
    numbers = "none",
    
    -- Close command when clicking close button
    close_command = "bdelete! %d",
    
    -- Always show bufferline (even with single buffer)
    always_show_bufferline = true,
    
    -- Show close buttons on tabs
    show_buffer_close_icons = true,
    show_close_icon = true,
    
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
    tab_size = 22,
    
    -- Hover effect configuration
    hover = {
      enabled = true,
      delay = 200,
      reveal = {'close'}
    },
    
    -- Buffer sorting method
    sort_by = 'insert_after_current',
    
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
        text = "File Explorer",
        text_align = "center",
        separator = true
      },
      {
        filetype = "neo-tree",
        text = "Neo-tree",
        text_align = "center",
        separator = true
      },
      {
        filetype = "alpha",
        text = "Dashboard",
        text_align = "center",
        separator = true
      },
    },
  },
  
  highlights = {
    -- Main bufferline background
    fill = {
      bg = '#000000',
      fg = '#1a1a1a',
    },

    -- Selected tab - transparent background with white text
    buffer_selected = {
      fg = '#f3f3f3',        
      bg = 'NONE',          
      bold = true,         
      italic = false,     
    },
    
    -- Close button on selected tab
    close_button_selected = {
      fg = '#ffffff',
      bg = 'NONE',
    },
    
    -- Modified indicator on selected tab
    modified_selected = {
      fg = '#ffaa00',        
      bg = 'NONE',
    },
    
    -- Duplicate indicator on selected tab
    duplicate_selected = {
      fg = '#cccccc',
      bg = 'NONE',
    },
    
    -- Visible/inactive tabs
    buffer_visible = {
      fg = '#888888',     
      bg = '#000000',      
      italic = false,
    },
    
    -- Visible tab numbers
    numbers_visible = {
      fg = '#666666',
      bg = '#1a1a1a',
    },
    
    -- Close button on visible tabs
    close_button_visible = {
      fg = '#666666',
      bg = '#1a1a1a',
    },
    
    -- Modified indicator on visible tabs
    modified_visible = {
      fg = '#ffaa00',
      bg = '#1a1a1a',
    },

    -- Hidden/background tabs
    buffer = {
      fg = '#666666',          -- Darker gray for background tabs
      bg = '#f3f3f3',         -- Very dark background
    },
    
    -- Background tab numbers
    numbers = {
      fg = '#444444',
      bg = '#0d0d0d',
    },
    
    -- Close button on background tabs
    close_button = {
      fg = '#444444',
      bg = '#0d0d0d',
    },
    
    -- Modified indicator on background tabs
    modified = {
      fg = '#cc8800',
      bg = '#0d0d0d',
    },

    -- Separators between tabs (light white borders)
    separator_selected = {
      fg = '#333333',          -- Light gray separator for selected tab
      bg = 'NONE',
    },
    
    separator_visible = {
      fg = '#2a2a2a',          -- Darker separator for visible tabs
      bg = '#1a1a1a',
    },
    
    separator = {
      fg = '#1a1a1a',          -- Very dark separator for background tabs
      bg = '#0d0d0d',
    },
    
    -- Tab close button hover effects
    close_button_selected = {
      fg = '#ff6b6b',          -- Red on hover for selected tab
      bg = 'NONE',
    },
    
    -- Error/warning diagnostic styling
    error = {
      fg = '#ff5555',
      bg = '#0d0d0d',
    },
    
    error_selected = {
      fg = '#ff5555',
      bg = 'NONE',
    },
    
    warning = {
      fg = '#ffaa00',
      bg = '#0d0d0d',
    },
    
    warning_selected = {
      fg = '#ffaa00',
      bg = 'NONE',
    },
  }
}

-- Command to close all buffers except current
vim.api.nvim_create_user_command('BufferLineCloseAll', function()
  vim.cmd('BufferLineCloseLeft')
  vim.cmd('BufferLineCloseRight')
end, { desc = 'Close all buffers except current' })

