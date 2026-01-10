-- nvim-cmp: no popup, no snippets; Tab is free for Copilot
-- ==========================================================================

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  config = function()
    local cmp = require("cmp")

    -- Disable automatic popup and all completion
    cmp.setup({
      completion = { autocomplete = false },
      window = {
        completion = cmp.config.disable,
        documentation = cmp.config.disable,
      },
      snippet = {
        expand = function(args)
          -- Snippets disabled
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-e>"] = cmp.mapping.abort(),
      }),
      sources = {},
    })
  end,
}
