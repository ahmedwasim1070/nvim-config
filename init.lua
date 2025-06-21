vim.fn.sign_define("NvimTreeDiagnosticErrorIcon", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("NvimTreeDiagnosticWarnIcon", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("NvimTreeDiagnosticInfoIcon", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("NvimTreeDiagnosticHintIcon", { text = "󰌶", texthl = "DiagnosticSignHint" })

vim.opt.number = true
vim.opt.relativenumber = false

require("ahmedwasim1070")
