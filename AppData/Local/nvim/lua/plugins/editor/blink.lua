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
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "scroll_signature_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "scroll_signature_down", "fallback" },
      ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
    },
    completion = {
      menu = {
        cmdline_position = function()
          if vim.g.ui_cmdline_pos ~= nil then
            return vim.g.ui_cmdline_pos
          end
          local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
          return { vim.o.lines - height, 0 }
        end,
        draw = {
          columns = { { "kind_icon" }, { "label", gap = 1 } },
          components = {
            label = {
              width = { fill = true, max = 60 },
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
            -- kind_icon = {
            --   text = function(ctx)
            --     ---@module "lazyvim.types"
            --     local icon = LazyVim.config.icons.kinds[ctx.kind] or ctx.kind_icon
            --     return icon .. ctx.icon_gap
            --   end,
            -- },
          },
        },
      },
      documentation = {},
    },
    signature = {
      enabled = true,
      window = {
        show_documentation = true,
        scrollbar = true,
        max_height = 15,
      },
    },
  },
}
