return {
  {
    "zbirenbaum/copilot.lua",
    dependencies = {
      "folke/sidekick.nvim",
    },
  },
  {
    "folke/sidekick.nvim",
    optional = true,
    ---@module "sidekick"
    ---@type sidekick.Config
    opts = {
      cli = {
        ---@type table<string, sidekick.cli.Tool|{}>
        tools = {
          copilot = {
            cmd = { "copilot" },
          },
          -- opencode = {
          --   cmd = { "opencode" },
          --   env = { OPENCODE_THEME = "catppuccin-macchiato" },
          -- },
        },
        ---@type sidekick.win.Opts
        win = {
          split = {
            width = math.floor(vim.o.columns * 0.4),
          },
          -- keys = {
          --   stopinsert = { "<esc><esc>", "stopinsert", mode = "t" },
          -- },
        },
      },
    },
    keys = {
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>ao",
        function()
          require("sidekick.cli").toggle({ name = "opencode", focus = true })
        end,
        desc = "Sidekick OpenCode Toggle",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      -- remove sidekick lualine component
      table.remove(opts.sections.lualine_x, 2)
      table.remove(opts.sections.lualine_x, 2)
    end,
  },
}
