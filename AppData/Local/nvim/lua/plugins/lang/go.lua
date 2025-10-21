return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ---@type vim.lsp.Config
        golangci_lint_ls = {
          filetypes = { "go" },
          before_init = function(...) end,
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = function(_, opts)
          if opts.ensure_installed then
            opts.ensure_installed = vim.tbl_filter(
              function(pkg) return pkg ~= "golangci-lint" end,
              opts.ensure_installed
            )
          end
        end,
      },
    },
    opts = function(_, opts) opts.linters_by_ft.go = nil end,
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
