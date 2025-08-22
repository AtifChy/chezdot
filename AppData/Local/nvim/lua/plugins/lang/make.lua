return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = { ensure_installed = { "autotools_ls" } },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "make" } },
  },
  -- {
  --   "mfussenegger/nvim-lint",
  --   opts = {
  --     linters_by_ft = {
  --       make = { "checkmake" },
  --     },
  --   },
  -- },
}
