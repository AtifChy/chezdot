---@module "lazy.pkg.packspec"
---@type LazySpec[]
return {
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      filetypes = { "*", "!lazy", "!noice" },
      buftypes = { "!nofile" },
      lazy_load = true,
      options = {
        parsers = {
          css = true,
          css_fn = true,
          names = {
            enable = false,
          },
          tailwind = {
            enable = true,
            update_names = true,
            lsp = {
              enable = true,
              -- disable_document_color = true,
            },
          },
        },
        display = {
          mode = "virtualtext",
          virtualtext = {
            char = "",
            position = "before",
            hl_mode = "foreground",
          },
        },
      },
    },
  },
  {
    "nvim-colorizer.lua",
    opts = function()
      local colorizer = require("colorizer")
      ---@module "snacks"
      Snacks.toggle({
        name = "Colorizer",
        get = function()
          return colorizer.is_buffer_attached()
        end,
        set = function(state)
          if state then
            colorizer.attach_to_buffer()
          else
            colorizer.detach_from_buffer()
          end
        end,
      }):map("<leader>uH")
    end,
  },
}
