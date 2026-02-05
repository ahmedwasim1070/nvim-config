local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then return end

local formatting = null_ls.builtins.formatting

null_ls.setup({
  sources = {
    -- JS/TS/HTML/CSS
    formatting.prettier, 
    -- Python
    formatting.black,
    -- Lua
    formatting.stylua,
  },
  
  -- AUTO-FORMAT ON SAVE
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})
