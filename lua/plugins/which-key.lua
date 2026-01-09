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
      { "<leader>d", group = "debug" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Conditional Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dn", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "Open REPL" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
      { "<leader>c", group = "cmake" },
      { "<leader>cc", ":CMakeConfigure<CR>", desc = "CMake Configure" },
      { "<leader>cb", ":CMakeBuild<CR>", desc = "CMake Build" },
      { "<leader>cr", ":CMakeRun<CR>", desc = "CMake Run" },
      { "<leader>ct", ":CMakeSelectTarget<CR>", desc = "CMake Select Target" },
      { "<leader>l", group = "lsp" },
      { "<leader>ld", function() require("lsp_lines").toggle() end, desc = "Toggle Diagnostics" },
      { "<leader>r", group = "refactor" },
      { "<leader>rn", function() vim.lsp.buf.rename() end, desc = "Rename Symbol" },
      { "<leader>g", group = "go to" },
      { "<leader>gd", function() require("config.goto").definition() end, desc = "Go to Definition" },
      { "<leader>gr", function() require("config.goto").references("read") end, desc = "Go to Read (usages)" },
      { "<leader>gw", function() require("config.goto").references("write") end, desc = "Go to Write (writes)" },
    })
  end,
}
