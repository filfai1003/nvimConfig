-- nvim-dap: Debug Adapter Protocol setup for C/C++
-- ============================================================================

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "williamboman/mason.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup()

    -- Resolve codelldb path robustly (works even if Mason isn't ready yet)
    local codelldb_path
    local ok_mr, mr = pcall(require, "mason-registry")
    if ok_mr and mr.has_package and mr.has_package("codelldb") then
      local pkg = mr.get_package("codelldb")
      if pkg and pkg.is_installed and pkg:is_installed() and pkg.get_install_path then
        local install_path = pkg:get_install_path()
        codelldb_path = install_path .. "/extension/adapter/codelldb"
      end
    end
    if not codelldb_path then
      local fallback = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"
      if vim.loop.fs_stat(fallback) then
        codelldb_path = fallback
      end
    end
    if not codelldb_path then
      vim.notify("codelldb not installed. Open :Mason and install 'codelldb' to enable debugging.", vim.log.levels.WARN)
      return
    end

    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = codelldb_path,
        args = { "--port", "${port}" },
      },
    }

    -- C/C++ configurations
    dap.configurations.c = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }
    dap.configurations.cpp = dap.configurations.c

    -- Auto-open/close UI
    dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
    dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
    dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
  end,
}
