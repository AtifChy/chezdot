return {
  {
    "lewis6991/satellite.nvim",
    url = "https://github.com/anthraxx/satellite.nvim",
    branch = "fix/error-unable-to-get-view",
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
