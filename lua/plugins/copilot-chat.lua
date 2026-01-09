-- GitHub Copilot Chat: ask mode without context in modal popup
-- ============================================================================

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = false,
      show_help = "yes",
      proxy = nil,
      disable_extra_info = "no",
      language = "Italian",
      prompts = {
        Explain = "Spiega il seguente codice.",
        Review = "Revisa il seguente codice e fornisci suggerimenti di miglioramento.",
        Fix = "Correggi i bug nel seguente codice.",
        Optimize = "Ottimizza il seguente codice.",
        Docs = "Scrivi la documentazione per il seguente codice.",
        Tests = "Scrivi i test per il seguente codice.",
      },
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
      selection = function(source)
        local select = require("CopilotChat.select")
        return select.visual(source) or select.line(source)
      end,
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      local select = require("CopilotChat.select")
      
      chat.setup(opts)

      -- Keybinding principale: leader + a per Ask senza contesto (modal popup)
      vim.keymap.set("n", "<leader>a", function()
        local input = vim.fn.input("Ask Copilot: ")
        if input ~= "" then
          chat.ask(input, { selection = select.none })
        end
      end, { noremap = true, silent = true, desc = "Copilot Chat: Ask (popup)" })

      -- Keybinding rapido per domande comuni (optional)
      vim.keymap.set("n", "<leader>ce", "<cmd>CopilotChatExplain<cr>", 
        { noremap = true, silent = true, desc = "Copilot Chat: Explain" })
      vim.keymap.set("n", "<leader>cr", "<cmd>CopilotChatReview<cr>", 
        { noremap = true, silent = true, desc = "Copilot Chat: Review" })
      vim.keymap.set("n", "<leader>cf", "<cmd>CopilotChatFix<cr>", 
        { noremap = true, silent = true, desc = "Copilot Chat: Fix" })

      -- Selezionare il modello (optional)
      vim.keymap.set("n", "<leader>cm", "<cmd>CopilotChatModels<cr>", 
        { noremap = true, silent = true, desc = "Copilot Chat: Select Model" })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
