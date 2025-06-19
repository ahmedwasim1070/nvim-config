require('nvim-treesitter.configs').setup {
  -- Parsers for MERN stack, Python, Go, C/C++, and Java
  ensure_installed = {
    -- MERN Stack
    "javascript",
    "typescript",
    "tsx",
    "html",
    "css",
    "scss",
    "json",
    "yaml",
    "toml",
    "markdown",
    "markdown_inline",
    
    -- Backend & Database
    "python",
    "go",
    "sql",
    
    -- Systems Programming
    "c",
    "cpp",
    "java",
    
    -- Configuration & Utility
    "lua",
    "vim",
    "vimdoc",
    "bash",
    "dockerfile",
    "gitignore",
    "gitcommit",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {},

  highlight = {
    enable = true,
    
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
    
    -- Disable highlighting for large files
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },

  indent = {
    enable = true,
    -- Disable indentation for specific languages if problematic
    disable = { "python" }, -- Python indentation can be tricky with treesitter
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
      },
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      include_surrounding_whitespace = true,
    },
    
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
        ["]a"] = "@parameter.inner",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
        ["]A"] = "@parameter.inner",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[a"] = "@parameter.inner",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
        ["[A"] = "@parameter.inner",
      },
    },
    
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
  },

  -- Language-specific configurations
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters
    max_file_lines = nil, -- Do not enable for files with more than n lines
  },

  -- Folding based on treesitter
  fold = {
    enable = true,
  },

  -- Autopairs integration
  autopairs = {
    enable = true,
  },

  -- Context aware commenting
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },

  -- Additional modules for MERN development
  autotag = {
    enable = true,
    filetypes = {
      'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 
      'svelte', 'vue', 'tsx', 'jsx', 'rescript', 'xml',
      'php', 'markdown', 'astro', 'glimmer', 'handlebars', 'hbs'
    },
  },

  -- Playground for debugging treesitter
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
}

-- Set up folding based on treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false -- Disable folding at startup

-- Additional filetype associations for better recognition
vim.filetype.add({
  extension = {
    env = 'sh',
    envrc = 'sh',
    eslintrc = 'json',
    prettierrc = 'json',
    tsconfig = 'json',
  },
  filename = {
    ['.eslintrc'] = 'json',
    ['.prettierrc'] = 'json',
    ['.babelrc'] = 'json',
    ['tsconfig.json'] = 'json',
    ['package.json'] = 'json',
    ['.env'] = 'sh',
    ['.envrc'] = 'sh',
    ['Dockerfile'] = 'dockerfile',
    ['docker-compose.yml'] = 'yaml',
    ['docker-compose.yaml'] = 'yaml',
  },
  pattern = {
    ['%.env%..*'] = 'sh',
    ['.*%.component%.ts'] = 'typescript',
    ['.*%.service%.ts'] = 'typescript',
    ['.*%.module%.ts'] = 'typescript',
    ['.*%.spec%.ts'] = 'typescript',
    ['.*%.test%.ts'] = 'typescript',
    ['.*%.spec%.js'] = 'javascript',
    ['.*%.test%.js'] = 'javascript',
  },
})
