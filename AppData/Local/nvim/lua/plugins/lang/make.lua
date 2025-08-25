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
      linters_by_ft = {
        make = { "checkmake" },
      },
    },
  },
  {
    "Zeioth/makeit.nvim",
    url = "https://github.com/AtifChy/makeit.nvim",
    -- dir = "~/Desktop/makeit.nvim",
    cmd = { "MakeitOpen", "MakeitToggleResults", "MakeitRedo" },
    dependencies = { "stevearc/overseer.nvim" },
    opts = {
      picker = "snacks",
    },
  },
  {
    "stevearc/overseer.nvim",
    optional = true,
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>o", group = "overseer", icon = { icon = "", color = "purple" } },
      },
      icons = {
        rules = {
          { plugin = "overseer.nvim", icon = "", color = "purple" },
        },
      },
    },
  },
}
