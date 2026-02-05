local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local status_mason, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_mason then
	return
end

-- 1. THE SERVER LIST
local servers = {
	"clangd",
	"html",
	"cssls",
	"pyright",
	"gopls",
	"omnisharp",
	"lua_ls",
}

-- 2. Capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- 3. Common Attach
local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	local keymap = vim.keymap.set

	keymap("n", "gd", vim.lsp.buf.definition, opts)
	keymap("n", "K", vim.lsp.buf.hover, opts)
	keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
	keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	keymap("n", "<leader>f", vim.lsp.buf.format, opts)
end

-- 4. Setup Mason (Install Only)
mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

-- 5. THE MANUAL LOOP (Crash-Free Version)
for _, server in pairs(servers) do
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	-- LUA SETTINGS
	if server == "lua_ls" then
		opts.settings = { Lua = { diagnostics = { globals = { "vim" } } } }
	end

	-- C# (OMNISHARP) - DIRECT PATH METHOD
	if server == "omnisharp" then
		-- We construct the path manually.
		-- It is ALWAYS located here on Linux if installed via Mason.
		local omnisharp_dll = vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll"

		-- Command: "dotnet /path/to/OmniSharp.dll"
		opts.cmd = { "dotnet", omnisharp_dll }

		-- Essential settings
		opts.enable_roslyn_analyzers = true
		opts.analyze_open_documents_only = true
		opts.enable_import_completion = true
	end

	lspconfig[server].setup(opts)
end
