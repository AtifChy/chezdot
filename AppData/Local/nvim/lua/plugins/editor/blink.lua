return {
  "saghen/blink.cmp",
  dependencies = { "xzbdmw/colorful-menu.nvim" },
  version = false, -- Use the latest version
  build = "cargo build --release",
  ---@module "blink-cmp"
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "enter",
      ["<Tab>"] = {
        "select_next",
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = {
        "select_prev",
        "snippet_backward",
        "fallback",
      },
    },
    completion = {
      menu = {
        -- border = "rounded",
        draw = {
          columns = { { "kind_icon" }, { "label", gap = 1 } },
          components = {
            label = {
              width = { fill = true, max = 60 },
              text = function(ctx)
                local highlights_info = require("colorful-menu").blink_highlights(ctx)
                if highlights_info ~= nil then
                  -- Or you want to add more item to label
                  return highlights_info.label
                else
                  return ctx.label
                end
              end,
              highlight = function(ctx)
                local highlights = {}
                local highlights_info = require("colorful-menu").blink_highlights(ctx)
                if highlights_info ~= nil then
                  highlights = highlights_info.highlights
                end
                for _, idx in ipairs(ctx.label_matched_indices) do
                  table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                end
                return highlights
              end,
            },
            kind_icon = {
              text = function(ctx)
                local icon = vim.g.icons.kinds[ctx.kind] or ctx.kind_icon
                return icon .. ctx.icon_gap
              end,
            },
          },
        },
      },
      -- documentation = { window = { border = "rounded" } },
    },
    signature = {
      enabled = true,
      -- window = { border = "rounded" },
    },
  },
}
