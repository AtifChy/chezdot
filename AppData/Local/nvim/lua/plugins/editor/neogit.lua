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
      "olimorris/codecompanion.nvim",
      "rbong/flog-symbols",
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
        item = { "", "" },
        section = { "", "" },
      },
    },
    keys = {
      {
        "<leader>gg",
        function()
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
}
