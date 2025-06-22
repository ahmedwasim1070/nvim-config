vim.cmd([[colorscheme oxocarbon]]) -- set the variant

-- Set transparent background (COMPLETE VERSION)
vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight NormalFloat guibg=NONE ctermbg=NONE
  highlight FloatBorder guibg=NONE ctermbg=NONE
  highlight TelescopeNormal guibg=NONE ctermbg=NONE
  highlight TelescopeBorder guibg=NONE ctermbg=NONE
  highlight Pmenu guibg=NONE ctermbg=NONE
  
  " Fix for number line background
  highlight LineNr guibg=NONE ctermbg=NONE
  highlight CursorLineNr guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
  highlight FoldColumn guibg=NONE ctermbg=NONE
  
  " Additional transparency fixes
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
  highlight VertSplit guibg=NONE ctermbg=NONE
  highlight WinSeparator guibg=NONE ctermbg=NONE
  
  " NvimTree transparency
]])

-- Alternative: Using Lua API (same effect, different syntax)
--[[
local highlights = {
  "Normal", "NormalNC", "NormalFloat", "FloatBorder",
  "TelescopeNormal", "TelescopeBorder", "Pmenu",
  "LineNr", "CursorLineNr", "SignColumn", "FoldColumn",
  "EndOfBuffer", "VertSplit", "WinSeparator",
  "NvimTreeNormal", "NvimTreeNormalNC", "NvimTreeEndOfBuffer",
  "NvimTreeWinSeparator", "NvimTreeVertSplit"
}

for _, group in ipairs(highlights) do
  vim.api.nvim_set_hl(0, group, { bg = "NONE" })
end
--]]
