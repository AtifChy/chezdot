return {
  {
    "folke/noice.nvim",
    url = "https://github.com/AtifChy/noice.nvim",
    branch = "dev",
    ---@module "noice"
    ---@type NoiceConfig
    opts = {
      presets = {
        bottom_search = false,
        lsp_doc_border = vim.o.winborder ~= "",
      },
      lsp = {
        enabled = false,
        signature = {
          enabled = true,
        },
      },
    },
  },
}
