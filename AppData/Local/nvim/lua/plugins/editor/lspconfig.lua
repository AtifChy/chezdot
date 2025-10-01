return {
  "neovim/nvim-lspconfig",
  opts = {
    ---@type vim.diagnostic.Opts
    diagnostics = {
      float = {
        border = "rounded",
      },
    },
    codelens = {
      enabled = true,
    },
  },
}
