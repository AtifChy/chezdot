return {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "LazyFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- ensure TS core is loaded first
  },
  opts = {},
}
