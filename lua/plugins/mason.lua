-- Mason: Manage external tooling (LSP/DAP/Formatters)
-- ============================================================================

return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  config = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- Ensure essential tools are installed
    local mr = require("mason-registry")
    for _, pkg in ipairs({ "clangd", "codelldb" }) do
      if not mr.is_installed(pkg) then
        mr.get_package(pkg):install()
      end
    end
  end,
}
