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
-- Debugging (nvim-dap)
-- ============================================================================
keymap("n", "<leader>db", function() require("dap").toggle_breakpoint() end, opts)
keymap("n", "<leader>dB", function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, opts)
keymap("n", "<leader>dc", function() require("dap").continue() end, opts)
keymap("n", "<leader>dn", function() require("dap").step_over() end, opts)
keymap("n", "<leader>di", function() require("dap").step_into() end, opts)
keymap("n", "<leader>do", function() require("dap").step_out() end, opts)
keymap("n", "<leader>dr", function() require("dap").repl.open() end, opts)
keymap("n", "<leader>du", function() require("dapui").toggle() end, opts)

-- ============================================================================
-- CMake Tools
-- ============================================================================
keymap("n", "<leader>cc", ":CMakeConfigure<CR>", opts)
keymap("n", "<leader>cb", ":CMakeBuild<CR>", opts)
keymap("n", "<leader>cr", ":CMakeRun<CR>", opts)
keymap("n", "<leader>ct", ":CMakeSelectTarget<CR>", opts)