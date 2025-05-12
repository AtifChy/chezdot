return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    table.insert(opts.sections.lualine_x, {
      "lsp_status",
      icon = "", -- f013
      symbols = {
        -- Standard unicode symbols to cycle through for LSP progress:
        -- spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
        spinner = "",
        -- Standard unicode symbol for when LSP is done:
        done = "",
        -- Delimiter inserted between LSP names:
        separator = " ",
      },
      -- List of LSP names to ignore (e.g., `null-ls`):
      ignore_lsp = { "copilot" },
    })
    opts.sections.lualine_z = {
      function()
        return " " .. os.date("%I:%M%p")
      end,
    }
  end,
}
