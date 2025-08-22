return {
  {
    "folke/noice.nvim",
    url = "https://github.com/dpetka2001/noice.nvim",
    branch = "fix/msg_show.shell_out",
    opts = {
      presets = {
        bottom_search = false,
        -- lsp_doc_border = true,
      },
      lsp = {
        enabled = false,
        signature = {
          enabled = false,
        },
      },
    },
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     diagnostics = {
  --       float = {
  --         border = "rounded",
  --       },
  --     },
  --   },
  -- },
}
