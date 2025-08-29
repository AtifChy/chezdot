return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      tex = { "latexindent" },
    },
    formatters = {
      latexindent = {
        prepend_args = { "-m", "-l" },
      },
      prettier = {
        prepend_args = { "--trailing-comma", "none" },
      },
    },
  },
}
