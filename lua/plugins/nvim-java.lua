-- nvim-java: Painless Java in Neovim
-- ============================================================================

return {
  "nvim-java/nvim-java",
  ft = "java",
  dependencies = {
    "nvim-java/lua-async-await",
    "nvim-java/nvim-java-core",
    "nvim-java/nvim-java-test",
    "nvim-java/nvim-java-dap",
    "nvim-java/nvim-java-refactor",
    "MunifTanjim/nui.nvim",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
    {
      "JavaHello/spring-boot.nvim",
      commit = "218c0c26c14d99feca778e4d13f5ec3e8b1b60f0",
    },
  },
  config = function()
    require("java").setup()
    vim.lsp.enable("jdtls")
  end,
}
