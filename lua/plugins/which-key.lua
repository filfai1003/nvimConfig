-- which-key: Display available keybindings
-- ============================================================================

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local wk = require("which-key")
    wk.setup({
      -- Place popup bottom-right and avoid cursor overlap
      win = {
        row = math.huge,
        col = math.huge,
        no_overlap = true,
        width = 0.4, -- use 40% of the editor width
        height = { min = 4, max = 25 },
        padding = { 1, 2 },
        title = true,
      },
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      -- Force a single column by making box width equal container width
      layout = {
        width = { min = 9999 },
        spacing = 3,
      },
      show_help = true,
      show_keys = true,
    })

    -- Register keybindings groups with which-key
    wk.add({
      { "<leader>f", group = "telescope" },
      { "<leader>ff", ":Telescope find_files<CR>", desc = "Find Files" },
      { "<leader>fg", ":Telescope live_grep<CR>", desc = "Live Grep" },
      { "<leader>fb", ":Telescope buffers<CR>", desc = "Buffers" },
      { "<leader>fh", ":Telescope help_tags<CR>", desc = "Help Tags" },
      { "<leader>fe", ":Telescope file_browser<CR>", desc = "Explorer" },
      { "<leader>w", ":w<CR>", desc = "Save File" },
      { "<leader>q", ":q<CR>", desc = "Quit" },
    })
  end,
}
