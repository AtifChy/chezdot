return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 0,
        ignore_whitespace = true,
        virt_text_priority = 100,
        use_focus = true,
      },
      preview_config = {
        border = vim.o.winborder,
      },
    },
  },
  {
    "gitsigns.nvim",
    opts = function()
      ---@module "snacks"
      Snacks.toggle({
        name = "Git Blame",
        get = function()
          return require("gitsigns.config").config.current_line_blame
        end,
        set = function(state)
          require("gitsigns").toggle_current_line_blame(state)
        end,
      }):map("<leader>uB")
    end,
  },
}
