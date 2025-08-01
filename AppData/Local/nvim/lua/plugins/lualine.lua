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
      ignore_lsp = { "copilot", "cspell_ls" },
    })
    opts.sections.lualine_z = {
      function()
        return " " .. os.date("%I:%M")
      end,
    }
  end,
}
