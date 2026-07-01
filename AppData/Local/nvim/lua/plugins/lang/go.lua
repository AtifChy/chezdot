return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@type table<string, vim.lsp.Config|false>
      servers = {
        golangci_lint_ls = {
          init_options = {
            command = {
              "golangci-lint",
              "run",
              -- disable all output formats that might be enabled by the users .golangci.yml
              "--output.text.path=",
              "--output.tab.path=",
              "--output.html.path=",
              "--output.checkstyle.path=",
              "--output.junit-xml.path=",
              "--output.teamcity.path=",
              "--output.sarif.path=",
              -- disable stats output
              "--show-stats=false",
              -- enable JSON output to be used by the language server
              "--output.json.path=stdout",
              "--allow-parallel-runners=true",
            },
          },
        },
      },
    },
  },
  -- {
  --   "mufussenegger/nvim-lint",
  --   opts = {
  --     linters = {
  --       golangcilint = {
  --         args = {
  --           "run",
  --           "--output.json.path=stdout",
  --           -- Overwrite values possibly set in .golangci.yml
  --           "--output.text.path=",
  --           "--output.tab.path=",
  --           "--output.html.path=",
  --           "--output.checkstyle.path=",
  --           "--output.code-climate.path=",
  --           "--output.junit-xml.path=",
  --           "--output.teamcity.path=",
  --           "--output.sarif.path=",
  --           "--issues-exit-code=0",
  --           "--show-stats=false",
  --           function()
  --             return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
  --           end,
  --         },
  --       },
  --     },
  --   },
  -- },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = function(_, opts)
          if opts.ensure_installed then
            opts.ensure_installed = vim.tbl_filter(function(pkg)
              return pkg ~= "golangci-lint"
            end, opts.ensure_installed)
          end
        end,
      },
    },
    opts = function(_, opts)
      opts.linters_by_ft.go = nil
    end,
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
