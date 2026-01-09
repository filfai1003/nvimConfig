-- LSP Diagnostics: Display inline errors (like ErrorLens)
-- ============================================================================

return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  event = "LspAttach",
  config = function()
    require("lsp_lines").setup()

    -- Configure diagnostic display
    vim.diagnostic.config({
      virtual_text = false, -- Disable default virtual text (using lsp_lines instead)
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    -- Keybind to toggle virtual text on/off
    vim.keymap.set(
      "n",
      "<leader>ld",
      require("lsp_lines").toggle,
      { noremap = true, silent = true, desc = "Toggle Diagnostics" }
    )
  end,
}
