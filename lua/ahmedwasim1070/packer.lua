-- ~/.config/nvim/lua/ahmedwasim1070/packer.lua

-- Auto-install Packer if not present
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Auto-reload when saving this file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

-- Plugins
return require("packer").startup(function(use)
  use "wbthomason/packer.nvim" -- Packer manages itself

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    requires = { { "nvim-lua/plenary.nvim" } }
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }
  
use { "akinsho/bufferline.nvim", tag = "*", requires = "nvim-tree/nvim-web-devicons" }
  
  -- Automatically set up config after cloning packer.nvim
  if packer_bootstrap then
    require("packer").sync()
  end
end)
