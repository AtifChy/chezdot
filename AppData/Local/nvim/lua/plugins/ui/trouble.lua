return {
  "folke/trouble.nvim",
  ---@module "trouble"
  ---@type trouble.Config
  opts = {
    preview = {
      border = "none",
    },
    icons = {
      kinds = vim.g.icons,
    },
  },
}
