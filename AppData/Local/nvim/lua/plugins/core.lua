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
      },
      completion = {
        menu = {
          -- border = "rounded",
          draw = {
            columns = {
              { "kind_icon", "label", "label_description", gap = 1 },
              { "kind" },
            },
          },
        },
        -- documentation = { window = { border = "rounded" } },
      },
      signature = {
        enabled = true,
        window = {
          -- border = "rounded"
          -- show_documentation = false,
        },
      },
      -- fuzzy = { implementation = "prefer_rust_with_warning" },
    },
  },
}
