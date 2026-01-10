-- ============================================================================
-- Keybindings Configuration
-- ============================================================================

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- Insert Mode
-- ============================================================================
keymap("i", "jk", "<ESC>", opts)

-- ============================================================================
-- Normal Mode - Window Navigation
-- ============================================================================
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- ============================================================================
-- Leader Key Mappings
-- ============================================================================
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
keymap("n", "<leader>e", ":Ex<CR>", opts)
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)

-- ============================================================================
-- LSP Go-To Shortcuts
-- ============================================================================
keymap("n", "<leader>gd", function()
	require("config.goto").definition()
end, opts)

keymap("n", "<leader>gr", function()
	require("config.goto").references("read")
end, opts)

keymap("n", "<leader>gw", function()
	require("config.goto").references("write")
end, opts)
-- ============================================================================
-- Undotree
-- ============================================================================
keymap("n", "<leader>u", ":UndotreeToggle<CR>", opts)

-- ============================================================================
-- CMake Tools
-- ============================================================================
keymap("n", "<leader>cc", ":CMakeConfigure<CR>", opts)
keymap("n", "<leader>cb", ":CMakeBuild<CR>", opts)
keymap("n", "<leader>cr", ":CMakeRun<CR>", opts)
keymap("n", "<leader>ct", ":CMakeSelectTarget<CR>", opts)

-- ============================================================================
-- Java/Maven
-- ============================================================================
-- Helper to run terminal commands at bottom, replacing previous
local function run_terminal(cmd)
  -- Close existing terminal buffers
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
  -- Open new terminal at bottom
  vim.cmd("botright split | terminal " .. cmd)
end

keymap("n", "<leader>ji", function()
  local groupId = vim.fn.input("groupId (e.g., com.example.app): ")
  if groupId ~= "" then
    local artifactId = vim.fn.input("artifactId (e.g., myapp): ")
    if artifactId ~= "" then
      run_terminal("mvn archetype:generate -DgroupId=" .. groupId .. " -DartifactId=" .. artifactId .. " -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false")
    end
  end
end, opts)

keymap("n", "<leader>jc", function()
  run_terminal("mvn compile")
end, opts)

keymap("n", "<leader>jr", function()
  local mainClass = vim.fn.input("mainClass (e.g., com.example.app.App): ")
  if mainClass ~= "" then
    run_terminal("mvn exec:java -Dexec.mainClass=" .. mainClass)
  end
end, opts)

keymap("n", "<leader>jt", function()
  run_terminal("mvn test")
end, opts)

keymap("n", "<leader>jp", function()
  run_terminal("mvn package")
end, opts)

keymap("n", "<leader>jx", function()
  run_terminal("mvn clean")
end, opts)