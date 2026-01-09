-- nvim-lspconfig: Language Server Protocol setup (Neovim 0.11+)
-- ============================================================================

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Common on_attach callback for all servers
    local on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      local keymap = vim.keymap.set

      -- LSP keybindings
      keymap("n", "<leader>gd", function()
        require("config.goto").definition()
      end, opts)
      keymap("n", "<leader>gr", function()
        require("config.goto").references("read")
      end, opts)
      keymap("n", "<leader>gw", function()
        require("config.goto").references("write")
      end, opts)
      keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
      keymap("n", "K", vim.lsp.buf.hover, opts)
      keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    end

    -- ========================================================================
    -- Configure all language servers using vim.lsp.config (Neovim 0.11+)
    -- ========================================================================

    -- TypeScript / JavaScript (ts_ls)
    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    })

    -- Python (pylsp)
    vim.lsp.config("pylsp", {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        pylsp = {
          plugins = {
            pycodestyle = { enabled = true },
            pylint = { enabled = true },
            autopep8 = { enabled = true },
          },
        },
      },
    })

    -- C / C++ (clangd)
    vim.lsp.config("clangd", {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "c", "cpp", "cc" },
    })

    -- HTML
    vim.lsp.config("html", {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "html", "htm", "erb" },
    })

    -- CSS
    vim.lsp.config("cssls", {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "css", "scss", "less" },
    })

    -- Dart (dartls)
    vim.lsp.config("dartls", {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "dart" },
    })

    -- ========================================================================
    -- Enable all configured servers
    -- ========================================================================
    vim.lsp.enable({ "ts_ls", "pylsp", "clangd", "html", "cssls", "dartls" })
  end,
}
