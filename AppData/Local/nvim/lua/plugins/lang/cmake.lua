return {
  {
    "Civitasv/cmake-tools.nvim",
    url = "https://github.com/AtifChy/cmake-tools.nvim",
    dependencies = { "stevearc/overseer.nvim" },
    cmd = "CMakeQuickStart",
    opts = {
      cmake_generate_options = {
        "-G Ninja",
        "-DCMAKE_C_COMPILER=clang",
        "-DCMAKE_CXX_COMPILER=clang++",
        "-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
      },
      cmake_executor = {
        name = "overseer",
        default_opts = {
          overseer = {
            on_new_task = function()
              require("overseer").open({ enter = false, direction = "bottom" })
            end,
          },
        },
      },
      cmake_runner = {
        name = "overseer",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cmake = { "cmake_format" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        neocmake = false,
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = { ensure_installed = { "cmake" } },
  },
}
