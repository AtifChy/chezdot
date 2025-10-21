return {
  "folke/lazydev.nvim",
  optional = true,
  dependencies = {
    { "Bilal2453/luvit-meta", lazy = true },
    { "DrKJeff16/wezterm-types", lazy = true },
  },
  opts = function(_, opts)
    local config = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "wezterm-types", mods = { "wezterm" } },
      },
    }

    local wez_config = vim.fn.expand("~/.config/wezterm/*/*.lua", nil, true)
    table.insert(config.library, { path = wez_config, mods = { "wezterm" } })

    return vim.tbl_deep_extend("force", opts or {}, config)
  end,
}
