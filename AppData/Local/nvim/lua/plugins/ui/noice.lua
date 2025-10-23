return {
  {
    "folke/noice.nvim",
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
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "shell_out",
          },
          view = "notify",
          opts = {
            title = "Shell Output",
            level = "info",
            merge = true,
          },
        },
        {
          filter = {
            event = "msg_show",
            kind = "shell_err",
          },
          view = "notify",
          opts = {
            title = "Shell Error",
            level = "error",
            merge = true,
          },
        },
      },
    },
  },
}
