-- ~/.config/nvim/lua/config/lsp.lua

local lsp_zero = require("lsp-zero")

-- LSP Zero preset
lsp_zero.preset("recommended")

-- Configure LSP servers
lsp_zero.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	-- Key mappings
	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>vrr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)

	-- Format on save (optional)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end
end)

-- Get default capabilities
local capabilities = lsp_zero.get_capabilities()

-- Setup each LSP server directly
local lspconfig = require("lspconfig")

-- TypeScript/JavaScript (tsserver)
lspconfig.ts_ls.setup({
	on_attach = lsp_zero.on_attach,
	capabilities = capabilities,
	settings = {
		typescript = {
			preferences = {
				disableSuggestions = false,
			},
		},
	},
})

-- Python (pyright)
lspconfig.pyright.setup({
	on_attach = lsp_zero.on_attach,
	capabilities = capabilities,
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true,
			},
		},
	},
})

-- Python (ruff_lsp) - Fixed: changed from 'ruff' to 'ruff_lsp'
lspconfig.ruff.setup({
	on_attach = lsp_zero.on_attach,
	capabilities = capabilities,
	init_options = {
		settings = {
			args = {},
		},
	},
})

-- Go (gopls)
lspconfig.gopls.setup({
	on_attach = lsp_zero.on_attach,
	capabilities = capabilities,
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
})

-- C/C++ (clangd)
lspconfig.clangd.setup({
	on_attach = lsp_zero.on_attach,
	capabilities = capabilities,
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--function-arg-placeholders",
		"--fallback-style=llvm",
	},
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
		clangdFileStatus = true,
	},
})

-- HTML
lspconfig.html.setup({
	on_attach = lsp_zero.on_attach,
	capabilities = capabilities,
})

-- CSS
lspconfig.cssls.setup({
	on_attach = lsp_zero.on_attach,
	capabilities = capabilities,
})

-- Tailwind CSS
lspconfig.tailwindcss.setup({
	on_attach = lsp_zero.on_attach,
	capabilities = capabilities,
	settings = {
		tailwindCSS = {
			experimental = {
				classRegex = {
					"tw`([^`]*)",
					'tw="([^"]*)',
					'tw={"([^"}]*)',
					"tw\\.\\w+`([^`]*)",
					"tw\\(.*?\\)`([^`]*)",
				},
			},
		},
	},
})

-- Emmet
lspconfig.emmet_ls.setup({
	on_attach = lsp_zero.on_attach,
	capabilities = capabilities,
	filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
})

-- ESLint
lspconfig.eslint.setup({
	on_attach = lsp_zero.on_attach,
	capabilities = capabilities,
})

-- Lua

-- JSON
lspconfig.jsonls.setup({
	on_attach = lsp_zero.on_attach,
	capabilities = capabilities,
})

-- YAML
lspconfig.yamlls.setup({
	on_attach = lsp_zero.on_attach,
	capabilities = capabilities,
})

-- Bash
lspconfig.bashls.setup({
	on_attach = lsp_zero.on_attach,
	capabilities = capabilities,
})

-- Setup autocompletion
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

-- Helper function for tab completion
local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")

cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
	},
	formatting = lsp_zero.cmp_format(),
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),

		-- Tab completion
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		-- Shift+Tab for previous completion
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
})

-- Setup LuaSnip
require("luasnip.loaders.from_vscode").lazy_load()

-- Diagnostic configuration
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = false,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

-- Sign column icons
local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

-- Configure borders for LSP floating windows
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "rounded"
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
