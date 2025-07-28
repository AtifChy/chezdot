return {
  {
    "folke/noice.nvim",
    url = "https://github.com/dpetka2001/noice.nvim",
    branch = "fix/msg_show.shell_out",
    opts = {
      presets = {
        bottom_search = false,
        -- lsp_doc_border = true,
      },
      -- lsp = {
      --   enabled = false,
      -- },
    },
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     diagnostics = {
  --       float = {
  --         border = "rounded",
  --       },
  --     },
  --   },
  -- },
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
        ignore_lsp = { "copilot", "cspell_ls" },
      })
      opts.sections.lualine_z = {
        function()
          return " " .. os.date("%I:%M")
        end,
      }
    end,
  },
}
