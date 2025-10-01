return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = { ensure_installed = { "autotools_ls" } },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "make" } },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = { make = { "checkmake" } },
    },
  },
  {
    "Zeroth/makeit.nvim",
    url = "https://github.com/AtifChy/makeit.nvim",
    cmd = { "MakeitOpen", "MakeitToggleResults", "MakeitRedo" },
    dependencies = { "stevearc/overseer.nvim" },
    opts = { picker = "snacks" },
  },
  {
    "stevearc/overseer.nvim",
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
    },
  },
}
