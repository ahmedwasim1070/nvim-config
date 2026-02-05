local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- =========================
-- General Remaps
-- =========================
keymap("i", "jj", "<ESC>", opts)
keymap("v", "<C-c>", '"+y', opts)
keymap("n", "<C-v>", '"+p', opts)
keymap("i", "<C-v>", "<C-r>+", opts)

-- Comment toggle
keymap("n", "<C-_>", "gcc", { remap = true })
keymap("v", "<C-_>", "gc", { remap = true })

-- Visual indent stay selected
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- =========================
-- Telescope (Global)
-- =========================
keymap("n", "<leader>ff", "<cmd>Telescope find_files hidden=true no_ignore=true<CR>", opts)
keymap("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope git_files<CR>", opts)

-- =========================
-- NvimTree Global Toggle
-- =========================
local function toggle_focus()
  local api = require("nvim-tree.api")
  if not api.tree.is_visible() then
    api.tree.open()
  else
    local current_buf = vim.api.nvim_get_current_buf()
    if vim.bo[current_buf].filetype == "NvimTree" then
      vim.cmd("wincmd p") -- Jump to previous window (File)
    else
      api.tree.focus() -- Jump to Tree
    end
  end
end
keymap("n", "<C-Space>", toggle_focus, opts)


-- =========================
-- NvimTree INTERNAL Mappings
-- =========================
vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    local api = require("nvim-tree.api")
    local bufopts = { buffer = true, noremap = true, silent = true, nowait = true }

    -- === TELESCOPE SHORTCUTS (Inside Tree) ===
    -- Since Space is instant, we map 'ff' directly without leader
    keymap("n", "ff", "<cmd>Telescope find_files hidden=true no_ignore=true<CR>", bufopts)
    keymap("n", "fw", "<cmd>Telescope live_grep<CR>", bufopts)
    keymap("n", "fg", "<cmd>Telescope git_files<CR>", bufopts)

    -- === Custom Space Logic ===
    local function smart_space()
      local node = api.tree.get_node_under_cursor()
      if node.type == "directory" then
        api.node.open.edit() 
      else
        api.node.open.preview() 
      end
    end
    keymap("n", "<Space>", smart_space, bufopts)

    -- === Navigation ===
    keymap("n", "<CR>", api.node.open.edit, bufopts)
    keymap("n", "<2-LeftMouse>", api.node.open.edit, bufopts)
    keymap("n", "l", api.node.open.edit, bufopts)
    keymap("n", "h", api.node.navigate.parent_close, bufopts)

    -- === File Operations ===
    keymap("n", "%", api.fs.create, bufopts)      -- Create File/Folder
    keymap("n", "D", api.fs.remove, bufopts)      -- Delete
    keymap("n", "<F2>", api.fs.rename, bufopts)   -- Rename
    keymap("n", "x", api.fs.cut, bufopts)         -- Cut
    keymap("n", "c", api.fs.copy.node, bufopts)   -- Copy
    keymap("n", "p", api.fs.paste, bufopts)       -- Paste
    keymap("n", "y", api.fs.copy.filename, bufopts) -- Copy Name

    -- === Tree Controls ===
    keymap("n", "R", api.tree.reload, bufopts)
    keymap("n", "-", api.tree.change_root_to_parent, bufopts)
    keymap("n", ".", api.tree.change_root_to_node, bufopts)
    keymap("n", "W", api.tree.collapse_all, bufopts)
    keymap("n", "q", api.tree.close, bufopts)
    keymap("n", "?", api.tree.toggle_help, bufopts)

    -- === Resizing ===
    keymap("n", ">", ":vertical resize +2<CR>", bufopts)
    keymap("n", "<", ":vertical resize -2<CR>", bufopts)
  end,
})
