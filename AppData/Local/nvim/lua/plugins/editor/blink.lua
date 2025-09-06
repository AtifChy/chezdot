return {
  "saghen/blink.cmp",
  dependencies = {
    "xzbdmw/colorful-menu.nvim",
    "Bekaboo/dropbar.nvim", -- use dropbar icon set
  },
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
                -- Do something else
                return highlights
              end,
            },
            kind_icon = {
              text = function(ctx)
                local icon = require("dropbar.configs").opts.icons.kinds.symbols[ctx.kind] or ctx.kind_icon
                return icon .. ctx.icon_gap
              end,
            },
          },
          -- columns = {
          --   { "kind_icon" },
          --   { "label", "label_description", gap = 1 },
          --   { "kind" },
          -- },
          -- components = {
          --   kind_icon = {
          --     text = function(ctx)
          --       local icon = ctx.kind_icon
          --       if vim.tbl_contains({ "Path" }, ctx.source_name) then
          --         local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
          --         if dev_icon then
          --           icon = dev_icon
          --         end
          --       else
          --         icon = require("dropbar.configs").opts.icons.kinds.symbols[ctx.kind]
          --       end
          --
          --       return icon .. ctx.icon_gap
          --     end,
          --
          --     -- Optionally, use the highlight groups from nvim-web-devicons
          --     -- You can also add the same function for `kind.highlight` if you want to
          --     -- keep the highlight groups in sync with the icons.
          --     highlight = function(ctx)
          --       local hl = ctx.kind_hl
          --       if vim.tbl_contains({ "Path" }, ctx.source_name) then
          --         local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
          --         if dev_icon then
          --           hl = dev_hl
          --         end
          --       end
          --       return hl
          --     end,
          --   },
          --   kind = {
          --     text = function(ctx)
          --       return "<" .. ctx.kind .. ">"
          --     end,
          --     highlight = function(ctx)
          --       local hl = ctx.kind_hl
          --       if vim.tbl_contains({ "Path" }, ctx.source_name) then
          --         local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
          --         if dev_icon then
          --           hl = dev_hl
          --         end
          --       end
          --       return hl
          --     end,
          --   },
          -- },
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
