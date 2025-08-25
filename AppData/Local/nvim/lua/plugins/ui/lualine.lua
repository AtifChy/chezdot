return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        "lsp_status",
        icon = "",
        symbols = {
          spinner = "",
          done = "",
          separator = " ",
        },
        ignore_lsp = { "copilot", "cspell_ls", "typos_lsp" },
      })
      table.insert(opts.sections.lualine_x, {
        function()
          local linters = require("lint").get_running()
          if #linters == 0 then
            return ""
          end
          return "󱉶 " .. table.concat(linters, " ")
        end,
      })
      opts.sections.lualine_z = {
        function()
          return " " .. os.date("%I:%M")
        end,
      }
    end,
  },
  {
    "lualine.nvim",
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
