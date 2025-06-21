-- Ensure netrw is enabled
vim.g.loaded_netrw = nil
vim.g.loaded_netrwPlugin = nil

-- Netrw settings
vim.g.netrw_banner = 0 -- Remove the annoying top banner
vim.g.netrw_liststyle = 3 -- Tree-style listing
vim.g.netrw_keepdir = 0 -- Don't auto-cd to directory
vim.g.netrw_localcopydircmd = "cp -r" -- Use recursive copy

-- Make netrw remember cursor position
vim.cmd([[
  augroup netrw_config
    autocmd!
    autocmd FileType netrw setlocal relativenumber
    autocmd FileType netrw setlocal cursorline
  augroup END
]])
