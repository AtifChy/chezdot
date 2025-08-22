return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "cssls",
        "rust_analyzer",
        -- "typos_lsp",
      },
    },
    -- init = function()
    --   vim.lsp.config("typos_lsp", {
    --     init_options = {
    --       diagnosticSeverity = "Hint",
    --     },
    --   })
    -- end,
  },
}
