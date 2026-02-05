-- Plugins
require("ahmedwasim1070.plugins")
require("ahmedwasim1070.plugins.web-devicons")
require("ahmedwasim1070.plugins.telescope")
require("ahmedwasim1070.plugins.nvim-tree")
require("ahmedwasim1070.plugins.treesitter")
require("ahmedwasim1070.plugins.cmp")
require("ahmedwasim1070.plugins.lsp.mason")
require("ahmedwasim1070.plugins.lsp.lspconfig")
require("ahmedwasim1070.plugins.lsp.none-ls")

-- Core
require("ahmedwasim1070.core.keymaps")
require("ahmedwasim1070.core.options")
require("ahmedwasim1070.core.statusbar").setup()
require("ahmedwasim1070.core.theme").setup()
