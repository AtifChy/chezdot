return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = { golangci_lint_ls = {} },
    },
  },
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
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "fredrikaverpil/neotest-golang",
      {
        "mason-org/mason.nvim",
        opts = { ensure_installed = { "gotestsum" } },
      },
    },
    opts = {
      adapters = {
        ["neotest-golang"] = {
          dap_go_enabled = true, -- requires leoluz/nvim-dap-go
          runner = "gotestsum",
          log_level = vim.log.levels.DEBUG,
        },
      },
    },
  },
}
