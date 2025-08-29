return {
  "NeogitOrg/neogit",
  cmd = {
    "Neogit",
    "NeogitCommit",
    "NeogitLogCurrent",
    "NeogitResetState",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  ---@module "neogit"
  ---@type NeogitConfig
  opts = {
    highlight = {},
    integrations = {
      snacks = true,
    },
    graph_style = "unicode",
    process_spinner = true,
    signs = {
      -- { CLOSED, OPENED }
      hunk = { "", "" },
      item = { "", "" },
      section = { "", "" },
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
}
