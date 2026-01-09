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
      layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "center",
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
      { "<leader>e", ":Ex<CR>", desc = "Netrw Explorer" },
      { "<leader>w", ":w<CR>", desc = "Save File" },
      { "<leader>q", ":q<CR>", desc = "Quit" },
      { "<leader>u", ":UndotreeToggle<CR>", desc = "Undo Tree" },
      { "<leader>g", group = "go to" },
      { "<leader>gd", function() require("config.goto").definition() end, desc = "Go to Definition" },
      { "<leader>gr", function() require("config.goto").references("read") end, desc = "Go to Read (usages)" },
      { "<leader>gw", function() require("config.goto").references("write") end, desc = "Go to Write (writes)" },
    })
  end,
}
