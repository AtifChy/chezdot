return {
  {
    "m4xshen/hardtime.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      enabled = false,
    },
  },
  {
    "hardtime.nvim",
    opts = function()
      Snacks.toggle({
        name = "Hardtime",
        get = function()
          return require("hardtime").is_plugin_enabled
        end,
        set = function()
          require("hardtime").toggle()
        end,
      }):map("<leader>uH")
    end,
  },
}
