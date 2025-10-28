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

    ---@type string[]
    local wez_config = vim.fn.glob("~/.config/wezterm/*/*.lua", true, true)
    for _, path in ipairs(wez_config) do
      table.insert(config.library, { path = path, mods = { "wezterm" } })
    end

    return vim.tbl_deep_extend("force", opts, config)
  end,
}
