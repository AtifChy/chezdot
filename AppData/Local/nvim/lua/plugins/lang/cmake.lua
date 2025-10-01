---@module "lazy.pkg.packspec"
---@type LazySpec[]
return {
  {
    "Civitasv/cmake-tools.nvim",
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
      cmake_runner = { name = "overseer" },
    },
    config = function(_, opts)
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { desc = desc, silent = true })
      end
      map("n", "<leader>c?g", "<cmd>CMakeGenerate<cr>", "CMake: Generate")
      map("n", "<leader>c?r", "<cmd>CMakeRun<cr>", "CMake: Run")
      map("n", "<leader>c?C", "<cmd>CMakeClean<cr>", "CMake: Clean")
      map("n", "<leader>c?d", "<cmd>CMakeDebug", "CMake: Debug")
      map("n", "<leader>c?c", "<cmd>CMakeSelectConfigurePreset<cr>", "CMake: Select Configure Preset")
      map("n", "<leader>c?b", "<cmd>CMakeSelectBuildPreset<cr>", "CMake: Select Build Preset")
      map("n", "<leader>c?t", "<cmd>CMakeSelectBuildTarget<cr>", "CMake: Select Build Target")
      map("n", "<leader>c?q", "<cmd>CMakeQuickStart<cr>", "CMake: Quick Start")
      require("cmake-tools").setup(opts)
    end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>c?", group = "cmake" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = { cmake = { "cmake_format" } },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        neocmake = false,
        cmake = {},
      },
    },
  },
}
