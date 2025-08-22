return {
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
}
