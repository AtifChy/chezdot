return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = { ensure_installed = { "delve" } },
      },
      {
        "leoluz/nvim-dap-go",
        opts = {
          delve = {
            path = "dlv.cmd",
          },
        },
      },
    },
  },
  -- {
  --   "mfussenegger/nvim-lint",
  --   optional = true,
  --   dependencies = {
  --     {
  --       "mason-org/mason.nvim",
  --       opts = { ensure_installed = { "golangci-lint" } },
  --     },
  --   },
  --   opts = {
  --     linters_by_ft = {
  --       go = { "golangcilint" },
  --     },
  --     linters = {
  --       golangcilint = {
  --         cmd = "golangci-lint.cmd",
  --       },
  --     },
  --   },
  -- },
}
