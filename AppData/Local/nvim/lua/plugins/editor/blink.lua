return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "xzbdmw/colorful-menu.nvim",
      -- {
      --   "jdrupal-dev/css-vars.nvim",
      --   url = "https://github.com/AtifChy/css-vars.nvim",
      --   branch = "fix/blink",
      --   opts = {
      --     search_extensions = { ".js", ".ts", ".jsx", ".tsx" },
      --   },
      -- },
    },
    -- version = false, -- Use the latest version
    -- build = "cargo build --release",
    ---@module "blink-cmp"
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        -- preset = "enter",
        -- ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        -- ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        -- ["<C-b>"] = { "scroll_documentation_up", "scroll_signature_up", "fallback" },
        -- ["<C-f>"] = { "scroll_documentation_down", "scroll_signature_down", "fallback" },
        -- ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
      },
      sources = {
        -- per_filetype = {
        --   css = { inherit_defaults = true, "css_vars" },
        -- },
        providers = {
          -- css_vars = {
          --   name = "CSS",
          --   module = "css-vars.blink",
          --   score_offset = 50,
          -- },
          -- copilot = {
          --   name = "Copilot",
          -- },
        },
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
            columns = { { "kind_icon" }, { "label", "source_name", gap = 1 } },
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
              kind_icon = {
                text = function(ctx)
                  ---@module "lazyvim.types"
                  local icon = LazyVim.config.icons.kinds[ctx.kind] or ctx.kind_icon
                  return icon .. ctx.icon_gap
                end,
                highlight = function(ctx)
                  local hl_name = "BlinkCmpKind" .. ctx.kind

                  if ctx.kind == "Color" then
                    local doc = ctx.item.documentation
                    local content = (type(doc) == "table" and doc.value) or (type(doc) == "string" and doc) or ""

                    local hex = content:match("^#%x%x%x%x%x%x$")
                    if not hex then
                      return hl_name
                    end

                    hl_name = "HexColor" .. hex:sub(2)
                    if vim.fn.hlexists(hl_name) == 0 then
                      vim.api.nvim_set_hl(0, hl_name, { fg = hex, default = true })
                    end
                  end

                  return hl_name
                end,
              },
            },
          },
        },
        documentation = {
          -- draw = function(opts)
          --   local buf = opts.window.buf
          --   local item = opts.item
          --   if not buf or not item then
          --     return
          --   end
          --
          --   local details = vim.split(item.detail or "", "\n", { trimempty = true })
          --   if #details > 0 then
          --     table.insert(details, 1, string.format("```%s", vim.bo[vim.api.nvim_get_current_buf()].ft or ""))
          --     table.insert(details, "```")
          --   end
          --
          --   local lines = {}
          --
          --   if item.documentation then
          --     lines = vim.split(item.documentation.value or "", "\n", { trimempty = true })
          --   end
          --
          --   local visible_lines = vim.list_extend(details, lines)
          --   vim.api.nvim_buf_set_lines(buf, 0, -1, false, visible_lines)
          --
          --   vim.bo[buf].filetype = "markdown"
          -- end,
        },
      },
      signature = {
        enabled = true,
        window = {
          show_documentation = true,
          scrollbar = true,
          max_height = 20,
        },
      },
    },
  },
}
