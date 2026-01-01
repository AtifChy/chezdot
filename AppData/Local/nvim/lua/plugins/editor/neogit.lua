return {
  {
    "NeogitOrg/neogit",
    cmd = {
      "Neogit",
      "NeogitCommit",
      "NeogitLogCurrent",
      "NeogitResetState",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      -- "olimorris/codecompanion.nvim",
      "rbong/flog-symbols",
      "404pilo/aicommits.nvim",
    },
    ---@module "neogit"
    ---@type NeogitConfig
    opts = {
      integrations = {
        telescope = false,
        diffview = true,
        snacks = true,
      },
      graph_style = "unicode",
      signs = {
        -- { CLOSED, OPENED }
        hunk = { "", "" },
        -- item = { "", "" },
        -- section = { "", "" },
        -- item = { "▶", "▼" },
        -- section = { "▶", "▼" },
        item = { "", "" },
        section = { "", "" },
        -- item = { "", "" },
        -- section = { "", "" },
      },
    },
    keys = {
      {
        "<leader>gg",
        function()
          ---@module "lazyvim.types"
          require("neogit").open({
            cwd = LazyVim.root.git(),
          })
        end,
        desc = "Neogit",
        mode = { "n", "v" },
      },
      {
        "<leader>gG",
        function()
          require("neogit").open()
        end,
        desc = "Neogit (cwd)",
        mode = { "n", "v" },
      },
    },
  },
  {
    "404pilo/aicommits.nvim",
    lazy = true,
    url = "https://github.com/AtifChy/aicommits.nvim",
    branch = "fix/cross_platform",
    opts = {
      active_provider = "gemini-api",
      providers = {
        ["gemini-api"] = {
          enabled = true,
          model = "gemini-2.5-flash",
          max_length = 50,
          generate = 3,
          temperature = 0.7,
          max_tokens = 200,
          thinking_budget = 0,
        },
      },
    },
  },
}
