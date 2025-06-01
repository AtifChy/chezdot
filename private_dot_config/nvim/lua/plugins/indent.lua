return {
  "nmac427/guess-indent.nvim",
  event = "LazyFile",
  opts = {},
  config = function(_, opts)
    require("guess-indent").setup(opts)
  end,
}
