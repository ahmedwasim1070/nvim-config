local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

map("i","jj","<ESC>",opts)

map("i","<C-H>","<C-w>",opts)

map("n","<leader>qf",vim.cmd.Ex)

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", opts)
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", opts)
map("n", "<leader>fgs", "<cmd>Telescope git_status<CR>", opts)
map("n", "<leader>fc", "<cmd>Telescope commands<CR>", opts)

-- Bufferline
-- Switch to next buffer (like Ctrl+Tab in VS Code)
map('n', '<Tab>', ':BufferLineCycleNext<CR>', opts)         -- Next buffer in normal mode
map('i', '<Tab>', '<Esc>:BufferLineCycleNext<CR>', opts)    -- Next buffer from insert mode
-- Switch to previous buffer (like Ctrl+Shift+Tab in VS Code)  
map('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', opts)       -- Previous buffer in normal mode
map('i', '<S-Tab>', '<Esc>:BufferLineCyclePrev<CR>', opts)  -- Previous buffer from insert mode
-- Create new buffer/tab
map('n', '<leader>tn', ':enew<CR>', opts)                        -- Open new empty buffer
map('i', '<leader>tn', '<Esc>:enew<CR>', opts)                   -- Open new buffer from insert mode
-- Close current buffer/tab 
map('n', '<leader>tw', ':bdelete<CR>', opts)                     -- Close current buffer
map('i', '<leader>tw', '<Esc>:bdelete<CR>', opts)                -- Close buffer from insert mode
-- Move current buffer left/right in the tab bar
map('n', '<leader>tj', ':BufferLineMovePrev<CR>', opts)          -- Move buffer to the left
map('n', '<leader>tk', ':BufferLineMoveNext<CR>', opts)          -- Move buffer to the right
-- Jump to specific buffer by position (Alt+Number)
for i = 1, 9 do
  map('n', '<leader>t'..i..'', ':BufferLineGoToBuffer ' .. i .. '<CR>', opts)  -- Jump to buffer 1-9
end
-- Close multiple buffers
map('n', '<leader>tew', ':BufferLineCloseOthers<CR>', opts)   -- Close all buffers except current
map('n', '<leader>tall', ':BufferLineCloseAll<CR>', opts)      -- Close all buffers (custom command)
-- Buffer picker and organization
map('n', '<leader>tpin', ':BufferLineTogglePin<CR>', opts)    -- Pin/unpin current buffer
