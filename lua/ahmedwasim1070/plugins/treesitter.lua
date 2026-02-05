local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then return end

configs.setup {
  -- A list of parser names, or "all"
  ensure_installed = { 
    "c", "cpp", "lua", "javascript", "typescript", 
    "tsx", "json", "html", "css", "python", "go", "c_sharp" 
  },
  
  sync_install = false, 
  auto_install = true, 
  
  highlight = {
    enable = true, -- Activate highlighting
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true }, 
}
