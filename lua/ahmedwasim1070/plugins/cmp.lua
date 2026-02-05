local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then return end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then return end

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  
  -- PERFORMANCE SETTINGS (Anti-Lag)
  performance = {
    debounce = 60, -- Wait 60ms before asking for suggestions
    throttle = 30,
    fetching_timeout = 500,
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(), -- Up
    ["<C-j>"] = cmp.mapping.select_next_item(), -- Down
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),     -- Force trigger suggestion
    ["<C-e>"] = cmp.mapping.abort(),            -- Close menu
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enter to Select
    ["<Tab>"] = cmp.mapping.select_next_item(), -- Tab to go down (Nvim Way)
    ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Shift+Tab to go up
  }),

  -- How the menu looks
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  -- Where suggestions come from
  sources = cmp.config.sources({
    { name = "nvim_lsp" }, -- From the Language Server (Smart)
    { name = "luasnip" },  -- Snippets
    { name = "path" },     -- File paths
    { name = "buffer", keyword_length = 5 }, -- Words in file (Only triggers after 5 chars to reduce lag)
  }),
})
