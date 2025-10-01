return {
  "folke/lazydev.nvim",
  optional = true,
  dependencies = {
    { "Bilal2453/luvit-meta", lazy = true },
    { "DrKJeff16/wezterm-types", lazy = true },
  },
  opts = {
    library = {
      { path = "luvit-meta/library", words = { "vim%.uv" } },
      { path = "wezterm-types", mods = { "wezterm" } },
    },
  },
}
