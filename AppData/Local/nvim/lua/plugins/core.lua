return {
  {
    "LazyVim/LazyVim",
    url = "https://github.com/AtifChy/LazyVim",
    branch = "rolling",
  },
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "super-tab",
        -- ["<Tab>"] = {
        --   require("blink.cmp.keymap.presets").get("super-tab")["<Tab>"][1],
        --   require("lazyvim.util.cmp").map({ "snippet_forward", "ai_accept" }),
        --   "fallback",
        -- },
      },
    },
  },
}
