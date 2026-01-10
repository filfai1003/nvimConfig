-- Telescope: Fuzzy finder
-- ============================================================================

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
  },
  cmd = "Telescope",
  config = function()
    local telescope = require("telescope")
    local fb_actions = require("telescope._extensions.file_browser.actions")
    
    telescope.setup({
      defaults = {
        prompt_prefix = "🔍 ",
        selection_caret = "▶ ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            mirror = false,
            preview_width = 0.5,
          },
        },
      },
      extensions = {
        file_browser = {
          theme = "dropdown",
          previewer = false,
          initial_mode = "normal",
          mappings = {
            ["i"] = {
              ["<C-w>"] = function() vim.cmd('normal vbd') end,
              ["<C-a>"] = fb_actions.create,
              ["<C-r>"] = fb_actions.rename,
              ["<C-m>"] = fb_actions.move,
              ["<C-d>"] = fb_actions.remove,
              ["<C-o>"] = fb_actions.open,
            },
            ["n"] = {
              ["c"] = fb_actions.create,
              ["r"] = fb_actions.rename,
              ["m"] = fb_actions.move,
              ["d"] = fb_actions.remove,
              ["o"] = fb_actions.open,
              ["e"] = fb_actions.goto_parent_dir,
            },
          },
        },
      },
    })
    
    telescope.load_extension("file_browser")
  end,
}
