return {
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    dependencies = {
      "AndreM222/copilot-lualine",
    },
    opts = function(_, opts)
      table.remove(opts.sections.lualine_x, 2)
      local colors = require("copilot-lualine.colors")
      table.insert(opts.sections.lualine_x, 2, {
        "copilot",
        symbols = {
          status = {
            icons = {
              enabled = " ",
              sleep = " ",
              disabled = " ",
              warning = " ",
              unknown = " ",
            },
            hl = {
              enabled = colors.get_hl_value(0, "Keyword", "fg"),
              sleep = colors.get_hl_value(0, "Special", "fg"),
              disabled = colors.get_hl_value(0, "Comment", "fg"),
              warning = colors.get_hl_value(0, "WarningMsg", "fg"),
              unknown = colors.get_hl_value(0, "ErrorMsg", "fg"),
            },
          },
          spinners = "dots",
          spinner_color = colors.get_hl_value(0, "Constant", "fg"),
        },
        show_colors = true,
        show_loading = true,
      })
    end,
  },
}
