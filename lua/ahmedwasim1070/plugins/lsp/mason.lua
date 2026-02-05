-- lua/ahmedwasim1070/plugins/lsp/mason.lua
local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local status_null, mason_null_ls = pcall(require, "mason-null-ls")
if not status_null then
	return
end

mason.setup()

mason_null_ls.setup({
	ensure_installed = {
		"tsserver",
		"prettier",
		"stylua",
		"black",
	},
})
