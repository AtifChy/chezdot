return {
  "mfussenegger/nvim-lint",
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = { ensure_installed = { "golangci-lint" } },
    },
  },
  opts = {
    linters_by_ft = {
      go = { "golangcilint" },
    },
  },
}
