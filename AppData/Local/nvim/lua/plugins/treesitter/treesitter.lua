return {
  "nvim-treesitter/nvim-treesitter",
  event = function()
    return "LazyFile"
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
  },
}
