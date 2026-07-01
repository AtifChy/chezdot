return {
  -- {
  --   "stevearc/overseer.nvim",
  --   version = "v1.6.0",
  -- },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>o", group = "overseer", icon = { icon = "", color = "purple" } },
      },
      icons = {
        rules = {
          { plugin = "overseer.nvim", icon = "", color = "purple" },
        },
      },
    },
  },
}
