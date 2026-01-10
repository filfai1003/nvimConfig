-- GitHub Copilot Chat: ask mode without context in modal popup
-- ============================================================================

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    opts = {
      debug = false,
      show_help = "yes",
      proxy = nil,
      disable_extra_info = "no",
      language = "Italian",
      window = {
        layout = "float",
        relative = "editor",
        width = 0.7,
        height = 0.6,
        row = math.floor(vim.o.lines / 4),
        col = math.floor(vim.o.columns / 6),
        border = "rounded",
        title = "Copilot Chat",
        title_pos = "center",
        zindex = 1000,
      },
    },
    config = function(_, opts)
      require("CopilotChat").setup(opts)
      
      local chat = require("CopilotChat")

      -- Keybinding principale: leader + a per aprire Copilot Chat
      vim.keymap.set("n", "<leader>a", function()
        chat.open()
      end, { noremap = true, silent = true, desc = "Copilot Chat" })

      -- Keybinding per inviare il messaggio: Ctrl+S
      vim.keymap.set("n", "<C-s>", function()
        chat.submit()
      end, { noremap = true, silent = true, desc = "Submit Copilot Chat" })
      
      vim.keymap.set("i", "<C-s>", function()
        chat.submit()
      end, { noremap = true, silent = true, desc = "Submit Copilot Chat" })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
