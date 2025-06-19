
require('lualine').setup {
  options = {
    -- Use a dark theme that matches your setup
    theme = 'auto',
    
    -- Component separators 
    component_separators = { left = '', right = '' },
    
    -- Section separators 
    section_separators = { left = '|', right = '|' },
    
    -- Disable icons if you want pure text
    icons_enabled = true,
    
    -- Global default options for all sections
    globalstatus = true,  -- Single statusline for all windows
    refresh = {
      statusline = 100,   -- Refresh every 100ms
      tabline = 100,
      winbar = 100,
    },
  },
  
  sections = {
    lualine_a = {
      {
        'mode',
        fmt = function(str)
          return str 
        end,
      }
    },
    
    lualine_b = {
      {
        'branch',
        icon = '', 
      }
    },
    
    lualine_c = {
      {
        'filetype',
        colored = true,   
        icon_only = true,
      },
      {
        'filename',
        file_status = true,     
        newfile_status = false, 
        path = 1,              
	symbols = {
	        modified  = ' | ',    
		readonly  = ' | ',   
		unnamed   = ' | ',  
		newfile   = ' | ', 
	},
	shorting_target = 40, 
      },
      {
        'diff',
        -- Git diff indicators
        symbols = { added = '+', modified = '~', removed = '-' },
        diff_color = {
          added = { fg = '#98c379' },    
          modified = { fg = '#e5c07b' },
          removed = { fg = '#e06c75' },
        },
      }
    },
    
    lualine_x = {
      {
        'diagnostics',
        -- LSP diagnostics
        sources = { 'nvim_lsp', 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
        diagnostics_color = {
          error = { fg = '#e06c75' },   -- Red
          warn = { fg = '#e5c07b' },    -- Yellow
          info = { fg = '#61afef' },    -- Blue
          hint = { fg = '#98c379' },    -- Green
        },
      },
      {
        'encoding',
        fmt = string.upper,  -- Show encoding in uppercase
      },
      {
        'fileformat',
        symbols = {
          unix = ' ',
          dos = ' ',
          mac = ' ',
        }
      },
    },
    
    lualine_y = {
      {
        'progress',
        fmt = function()
          return '%P/%L'  -- Show current position / total lines
        end
      }
    },
    
    lualine_z = {
      {
        -- Custom component for current time
        function()
          return os.date('%H:%M')
        end,
        color = { fg = '#000000' },  -- Blue color for time
      }
    }
  },
  
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        'filename',
        file_status = true,
        path = 1,
        color = { fg = '#5c6370' }, 
      }
    },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  
  extensions = {
    'nvim-tree',   
    'toggleterm', 
    'quickfix',  
    'fugitive', 
    'fzf',     
  }
}

-- Custom function to show LSP server status
local function lsp_connection()
  local msg = 'No LSP'
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.get_active_clients()
  
  if next(clients) == nil then
    return msg
  end
  
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return client.name
    end
  end
  
  return msg
end

-- Force refresh lualine
vim.keymap.set('n', '<leader>lr', ':lua require("lualine").refresh()<CR>', 
  { desc = 'Refresh Lualine' })

-- Update lualine when LSP attaches/detaches
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function()
    require('lualine').refresh()
  end,
})

vim.api.nvim_create_autocmd('LspDetach', {
  callback = function()
    require('lualine').refresh()
  end,
})
