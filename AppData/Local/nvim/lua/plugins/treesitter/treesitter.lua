return {
  "nvim-treesitter/nvim-treesitter",
  enabled = true,
  event = function()
    return "LazyFile"
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
  },
  opts = {
    ensure_installed = {
      "css",
      "jsx",
    },
  },
}
