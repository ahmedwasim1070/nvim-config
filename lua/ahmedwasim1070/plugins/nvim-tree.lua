local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local function on_attach_dummy(bufnr)
end

nvim_tree.setup({
  on_attach = on_attach_dummy,
  sort_by = "case_sensitive",
  view = {
    width = 30,
    side = "left",
    cursorline = true, 
  },
  renderer = {
    group_empty = true,
    
    -- THE FIX: Show ONLY the folder name (e.g. "project")
    -- ":t" stands for "tail" (last part of path)
    root_folder_label = function(path)
      return vim.fn.fnamemodify(path, ":t")
    end,
    
    indent_markers = { enable = true },
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
})
