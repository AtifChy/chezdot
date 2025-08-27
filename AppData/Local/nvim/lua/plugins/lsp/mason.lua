return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "cssls",
        "rust_analyzer",
        -- "harper_ls",
      },
    },
  },
}
