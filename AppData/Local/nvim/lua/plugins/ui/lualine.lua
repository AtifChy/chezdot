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
        ignore_lsp = { "copilot", "cspell_ls", "typos_lsp", "harper_ls" },
        color = function()
          return { fg = Snacks.util.color("Identifier") }
        end,
      })
      table.insert(opts.sections.lualine_x, {
        function()
          local linters = require("lint").get_running()
          if #linters == 0 then
            return ""
          end
          return "󱉶 " .. table.concat(linters, " ")
        end,
        color = function()
          return { fg = Snacks.util.color("DiagnosticInfo") }
        end,
      })
      table.insert(opts.sections.lualine_x, {
        "fileformat",
        symbols = {
          unix = "",
          dos = "",
          mac = "",
        },
        color = function()
          return { fg = Snacks.util.color("Tag") }
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
      table.insert(opts.sections.lualine_x, 2, {
        "copilot",
        symbols = {
          status = {
            icons = {
              enabled = "",
              sleep = "",
              disabled = "",
              warning = "",
              unknown = "",
            },
            hl = {
              enabled = Snacks.util.color("Keyword"),
              sleep = Snacks.util.color("Special"),
              disabled = Snacks.util.color("Comment"),
              warning = Snacks.util.color("WarningMsg"),
              unknown = Snacks.util.color("ErrorMsg"),
            },
          },
          spinners = "dots",
          spinner_color = Snacks.util.color("Constant"),
        },
        show_colors = true,
        show_loading = true,
      })
    end,
  },
}
