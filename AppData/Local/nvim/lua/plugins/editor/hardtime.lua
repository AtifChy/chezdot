return {
  {
    "m4xshen/hardtime.nvim",
    cmd = "Hardtime",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      enabled = false,
    },
    init = function()
      require("snacks")
        .toggle({
          name = "Hardtime",
          get = function()
            return require("hardtime").is_plugin_enabled
          end,
          set = function()
            require("hardtime").toggle()
          end,
        })
        :map("<leader>um")
    end,
  },
}
