return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.section_separators = { left = "", right = "" }
      -- opts.options.component_separators = { left = "", right = "" }
      table.remove(opts.sections.lualine_x, 2)
      -- table.insert(opts.sections.lualine_x, {
      --   "lsp_status",
      --   icon = "",
      --   symbols = {
      --     spinner = "",
      --     done = "",
      --     separator = " ",
      --   },
      --   ignore_lsp = {
      --     "copilot",
      --     "cspell_ls",
      --     "typos_lsp",
      --     "harper_ls",
      --     -- "emmet_language_server",
      --   },
      --   -- show_name = false,
      --   color = function()
      --     return { fg = Snacks.util.color("DiagnosticInfo") }
      --   end,
      -- })
      -- table.insert(opts.sections.lualine_x, {
      --   function()
      --     local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
      --     for _, client in ipairs(vim.lsp.get_clients()) do
      --       local filetypes = client.config.filetypes
      --       if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      --         return "LSP"
      --       end
      --     end
      --     return ""
      --   end,
      --   icon = "",
      --   color = function()
      --     return { fg = Snacks.util.color("DiagnosticInfo") }
      --   end,
      -- })
      -- table.insert(opts.sections.lualine_x, {
      --   function()
      --     local linters = require("lint").get_running()
      --     if #linters == 0 then
      --       return ""
      --     end
      --     return "󱉶 " .. table.concat(linters, " ")
      --   end,
      --   color = function()
      --     return { fg = Snacks.util.color("DiagnosticWarn") }
      --   end,
      -- })
      table.insert(opts.sections.lualine_x, {
        "fileformat",
        symbols = {
          unix = "",
          dos = "",
          mac = "",
        },
        color = function()
          return { fg = Snacks.util.color("Identifier") }
        end,
      })
      opts.sections.lualine_z = {
        function()
          local hour12 = tonumber(os.date("%I"))
          local icons = {
            "󱑋",
            "󱑌",
            "󱑍",
            "󱑎",
            "󱑏",
            "󱑐",
            "󱑑",
            "󱑒",
            "󱑓",
            "󱑔",
            "󱑕",
            "󱑖",
          }
          local icon = icons[hour12]
          return icon .. " " .. os.date("%I:%M")
        end,
      }
    end,
  },
}
