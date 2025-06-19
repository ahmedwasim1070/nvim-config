vim.g.loaded_netrw = 1         
vim.g.loaded_netrwPlugin = 1  

require('nvim-tree').setup({
  auto_reload_on_write = true,

  hijack_directories = {
    enable = true,
    auto_open = true,
  },

  update_focused_file = {
    enable = true,
    update_root = false,
    ignore_list = {},
  },

  system_open = {
    cmd = nil, 
    args = {},
  },

  diagnostics = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
    debounce_delay = 50,
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    },
    icons = {
      hint    = "󰌶",
      info    = "",
      warning = "",
      error   = "", 
    }
  },

  view = {
    width = function()
      return math.floor(vim.o.columns * 0.21)
    end,
    side = "left",
    preserve_window_proportions = true,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    float = {
      enable = false, 
      quit_on_focus_loss = true,
      open_win_config = {
        relative = "editor",
        border = "rounded",
        width = 50,
        height = 30,
        row = 1,
        col = 1,
      },
    },
  },

  renderer = {
    add_trailing = true,
    group_empty = true,
    highlight_opened_files = "all",
    highlight_modified = "name",
    full_name = true,
    root_folder_label = ":t",
    indent_width = 2,
    indent_markers = {
      enable = true,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },
    icons = {
      webdev_colors = true,  
      git_placement = "before", 
      modified_placement = "after", 
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
        modified = true,
        diagnostics = true,
        bookmarks = true,
      },
      glyphs = {
        default = "󰈚",
        symlink = "",
        bookmark = "󰆤",
        modified = "●",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
    special_files = {
      "Cargo.toml", "Makefile", "README.md", "readme.md",
      "package.json", "package-lock.json", "yarn.lock",
      ".gitignore", ".env", "Dockerfile",
      "docker-compose.yml", "docker-compose.yaml",
    },
    symlink_destination = true,
  },

  hijack_cursor = false,

  on_attach = function(bufnr)
    local api = require('nvim-tree.api')
    
    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- Default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- Custom mappings
    vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
    vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
    vim.keymap.set('n', 'l',     api.node.open.edit,                    opts('Open'))
    vim.keymap.set('n', 'h',     api.node.navigate.parent_close,        opts('Close Directory'))
    vim.keymap.set('n', 'v',     api.node.open.vertical,                opts('Open: Vertical Split'))
    vim.keymap.set('n', 's',     api.node.open.horizontal,              opts('Open: Horizontal Split'))

    -- ✅ Your custom remaps
    vim.keymap.set('n', '%', api.fs.create, opts('Create File'))      
    vim.keymap.set('n', 'd', api.fs.create, opts('Create Folder'))   
    vim.keymap.set('n', 'ff', function() vim.cmd("Telescope find_files") end, opts('Find File in Project'))
    vim.keymap.set('n', 'D', api.fs.remove, opts('Delete File/Folder'))
  end,

  filters = {
    dotfiles = true,
    git_ignored = true,
  },

  git = {
    enable = true,
    ignore = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
    timeout = 400,
  },

  modified = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
  },

  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    expand_all = {
      max_folder_discovery = 300,
    },
    file_popup = {
      open_win_config = {
        col = 1,
        row = 1,
        relative = "cursor",
        border = "shadow",
        style = "minimal",
      },
    },
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = true,
        picker = "default",
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
    remove_file = {
      close_window = true,
    },
  },

  trash = {
    cmd = "gio trash",
  },

  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = true,
  },

  tab = {
    sync = {
      open = false,
      close = false,
      ignore = {},
    },
  },

  notify = {
    threshold = vim.log.levels.INFO,
  },

  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      dev = false,
      diagnostics = false,
      git = false,
      profile = false,
      watcher = false,
    },
  },
})

-- Autocmds (unchanged)
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function(data)
    local directory = vim.fn.isdirectory(data.file) == 1
    local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
    if directory then
      vim.cmd.cd(data.file)
      require("nvim-tree.api").tree.open()
    elseif no_name then
      if vim.fn.finddir('.git', '.;') ~= '' or 
         vim.fn.findfile('package.json', '.;') ~= '' or
         vim.fn.findfile('Cargo.toml', '.;') ~= '' or
         vim.fn.findfile('go.mod', '.;') ~= '' then
        require("nvim-tree.api").tree.open()
      end
    end
  end
})

vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local invalid_win = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match("NvimTree_") ~= nil then
        table.insert(invalid_win, w)
      end
    end
    if #invalid_win == #wins - 1 then
      for _, w in ipairs(invalid_win) do vim.api.nvim_win_close(w, true) end
    end
  end
})

vim.keymap.set('n', '<leader>n', ':NvimTreeFocus<CR>', { desc = 'Focus NvimTree' })
vim.keymap.set('n', '<leader>nt', ':NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })
vim.keymap.set('n', '<leader>nff', ':NvimTreeFindFile<CR>', { desc = 'Find file in NvimTree' })
vim.keymap.set('n', '<leader>nq', ':NvimTreeCollapse<CR>', { desc = 'Collapse NvimTree' })
vim.keymap.set('n', '<leader>nr', ':NvimTreeRefresh<CR>', { desc = 'Refresh NvimTree' })

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#1a1a1a" })
    vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "#1a1a1a" })
    vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { fg = "#61afef", bold = true })
    vim.api.nvim_set_hl(0, "NvimTreeModifiedFile", { fg = "#e5c07b" })
    vim.api.nvim_set_hl(0, "NvimTreeGitDirty", { fg = "#e5c07b" })
    vim.api.nvim_set_hl(0, "NvimTreeGitNew", { fg = "#98c379" })
    vim.api.nvim_set_hl(0, "NvimTreeGitDeleted", { fg = "#e06c75" })
  end,
})
