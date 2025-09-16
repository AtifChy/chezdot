return {
  "folke/lazydev.nvim",
  dependencies = {
    { "DrKJeff16/wezterm-types", lazy = true },
  },
  opts = {
    library = {
      { path = "wezterm-types", mods = { "wezterm" } },
    },
  },
}
