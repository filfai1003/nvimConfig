-- Plugin Manager Setup
-- ============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local specs = {
  require("plugins.tokyonight"),
  require("plugins.which-key"),
  require("plugins.telescope"),
  require("plugins.nvim-cmp"),
  require("plugins.copilot"),
  require("plugins.lspconfig"),
  require("plugins.undotree"),
  require("plugins.lsp-lines"),
}

require("lazy").setup(specs, {
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})
