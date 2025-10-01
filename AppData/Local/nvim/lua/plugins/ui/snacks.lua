return {
  "folke/snacks.nvim",
  ---@module "snacks"
  ---@type snacks.Config
  opts = {
    statuscolumn = {
      left = { "mark", "sign" },
      right = { "git", "fold" },
      folds = {
        open = true,
        git_hl = true,
      },
    },
    picker = {
      win = {
        preview = {
          wo = {
            wrap = true,
          },
        },
      },
    },
    styles = {
      notification = {
        wo = {
          wrap = true,
        },
      },
    },
  },
}
