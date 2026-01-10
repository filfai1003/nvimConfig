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
      { "<leader>a", function() require("CopilotChat").open() end, desc = "Copilot Chat" },
      { "<leader>c", group = "cmake" },
      { "<leader>cb", ":CMakeBuild<CR>", desc = "CMake Build" },
      { "<leader>cc", ":CMakeConfigure<CR>", desc = "CMake Configure" },
      { "<leader>cr", ":CMakeRun<CR>", desc = "CMake Run" },
      { "<leader>ct", ":CMakeSelectTarget<CR>", desc = "CMake Select Target" },
      { "<leader>e", ":Ex<CR>", desc = "Netrw Explorer" },
      { "<leader>f", group = "telescope" },
      { "<leader>fb", ":Telescope buffers<CR>", desc = "Buffers" },
      { "<leader>fe", ":Telescope file_browser<CR>", desc = "File Browser" },
      { "<leader>ff", ":Telescope find_files<CR>", desc = "Find Files" },
      { "<leader>fg", ":Telescope live_grep<CR>", desc = "Live Grep" },
      { "<leader>fh", ":Telescope help_tags<CR>", desc = "Help Tags" },
      { "<leader>g", group = "go to" },
      { "<leader>gd", function() require("config.goto").definition() end, desc = "Go to Definition" },
      { "<leader>gr", function() require("config.goto").references("read") end, desc = "Go to Read (usages)" },
      { "<leader>gw", function() require("config.goto").references("write") end, desc = "Go to Write (writes)" },
      { "<leader>j", group = "java" },
      { "<leader>ji", function() local g = vim.fn.input("groupId: "); if g ~= "" then local a = vim.fn.input("artifactId: "); if a ~= "" then vim.cmd("split | terminal mvn archetype:generate -DgroupId=" .. g .. " -DartifactId=" .. a .. " -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false") end end end, desc = "Maven Init" },
      { "<leader>jc", ":split | terminal mvn compile<CR>", desc = "Maven Compile" },
      { "<leader>jr", function() local m = vim.fn.input("mainClass: "); if m ~= "" then vim.cmd("split | terminal mvn exec:java -Dexec.mainClass=" .. m) end end, desc = "Maven Run" },
      { "<leader>jt", ":split | terminal mvn test<CR>", desc = "Maven Test" },
      { "<leader>jp", ":split | terminal mvn package<CR>", desc = "Maven Package" },
      { "<leader>jx", ":split | terminal mvn clean<CR>", desc = "Maven Clean" },
      { "<leader>l", group = "lsp" },
      { "<leader>ld", function() require("lsp_lines").toggle() end, desc = "Toggle Diagnostics" },
      { "<leader>q", ":q<CR>", desc = "Quit" },
      { "<leader>r", group = "refactor" },
      { "<leader>rn", function() vim.lsp.buf.rename() end, desc = "Rename Symbol" },
      { "<leader>u", ":UndotreeToggle<CR>", desc = "Undo Tree" },
      { "<leader>w", ":w<CR>", desc = "Save File" },
    })
  end,
}
