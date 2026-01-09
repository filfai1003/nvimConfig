-- nvim-cmp: no popup, keep snippets; Tab is free for Copilot
-- ==========================================================================

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)

    -- Disable automatic popup; we use Copilot for inline AI and LuaSnip for snippets
    cmp.setup({
      completion = { autocomplete = false },
      window = {
        completion = cmp.config.disable,
        documentation = cmp.config.disable,
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-e>"] = cmp.mapping.abort(),
      }),
      sources = {},
    })

    -- Enter: espande o salta snippet; altrimenti newline
    vim.keymap.set({ "i", "s" }, "<CR>", function()
      if luasnip.expand_or_jumpable() then
        return "<Plug>luasnip-expand-or-jump"
      end
      return "<CR>"
    end, { expr = true, silent = true, desc = "LuaSnip expand/jump or newline" })
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true }) -- Tab conferma la scelta corrente
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "luasnip" },
      }),
    })
  end,
}
