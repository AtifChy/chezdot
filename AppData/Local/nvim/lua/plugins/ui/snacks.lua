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
    scroll = {
      animate = {
        duration = { step = 10, total = 150 },
        easing = "linear",
      },
      -- faster animation when repeating scroll after delay
      animate_repeat = {
        delay = 100, -- delay in ms before using the repeat animation
        duration = { step = 5, total = 50 },
        easing = "linear",
      },
    },
    image = {
      enabled = true,
      math = { enabled = false },
    },
    -- input = {
    --   win = {
    --     relative = "cursor",
    --     row = -3,
    --     col = 0,
    --     width = 30,
    --   },
    -- },
  },
}
