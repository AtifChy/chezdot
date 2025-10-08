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
        inc_rename = {
          cmdline = {
            format = {
              IncRename = {
                title = " Rename ",
              },
            },
          },
        },
      },
      lsp = {
        signature = {
          enabled = false,
        },
        hover = {
          enabled = false,
        },
      },
    },
  },
}
