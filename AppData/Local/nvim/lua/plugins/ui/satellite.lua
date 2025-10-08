return {
  {
    "lewis6991/satellite.nvim",
    event = "LazyFile",
    opts = {
      handlers = {
        cursor = {
          symbols = { "•" },
        },
        gitsigns = {
          signs = {
            delete = "",
          },
        },
      },
    },
  },
}
