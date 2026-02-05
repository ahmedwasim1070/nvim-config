local M = {}

-- 1. Define Mode Names
local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "V-LINE",
  ["\22"] = "V-BLOCK",
  ["s"] = "SELECT",
  ["S"] = "S-LINE",
  ["\19"] = "S-BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "V-REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

-- 2. Get Current Mode
local function get_mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format(" %s ", modes[current_mode] or current_mode):upper()
end

-- 3. Get Filepath
local function get_filename()
  local filepath = vim.fn.expand("%:~:.") 
  if filepath == "" then return " [No Name] " end
  local max_len = 45 
  if #filepath > max_len then
    filepath = filepath:sub(1, max_len - 3) .. "..."
  end
  return " " .. filepath .. " "
end

-- 4. Get Git Branch (Updated)
local function get_git()
  local branch = vim.b.gitsigns_head
  if not branch or branch == "" then
    return "     NOT-GIT " 
  end
  return "    " .. branch .. " "
end

-- 5. Get Ruler
local function get_ruler()
  return " %l/%L "
end

-- ==========================================
-- The Main Render Function
-- ==========================================
function M.render_active()
  if vim.bo.filetype == "NvimTree" then
    return "%#Normal# NVIM "
  end

  return table.concat({
    "%#StatusLineMode#",
    get_mode(),
    "%#StatusLine#",
    get_filename(),
    "%=",
    get_ruler(),
    "%#StatusLineGit#",
    get_git(),
  })
end

function M.setup()
  local status_ok, gitsigns = pcall(require, "gitsigns")
  if status_ok then gitsigns.setup() end
  vim.opt.statusline = "%!v:lua.require('ahmedwasim1070.core.statusbar').render_active()"
end

return M
