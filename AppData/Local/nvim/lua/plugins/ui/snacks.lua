return {
  "folke/snacks.nvim",
  url = "https://github.com/dpetka2001/snacks.nvim",
  branch = "fix/statuscolumn_open_folds",
  ---@module "snacks"
  ---@type snacks.Config
  opts = {
    statuscolumn = {
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
