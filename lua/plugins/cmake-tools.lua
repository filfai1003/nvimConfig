-- CMake Tools: Automate configure/build/run
-- ============================================================================

return {
  "Civitasv/cmake-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  ft = { "c", "cpp", "cmake" },
  config = function()
    require("cmake-tools").setup({
      cmake_soft_link_binary = false,
      cmake_regenerate_on_save = true,
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" },
      cmake_build_options = {},
      cmake_console_size = 10,
      cmake_console_position = "belowright",
    })
  end,
}
