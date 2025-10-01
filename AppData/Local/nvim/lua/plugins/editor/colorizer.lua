---@module "lazy.pkg.packspec"
---@type LazySpec[]
return {
  {
    "nvim-mini/mini.hipatterns",
    enabled = false,
  },
  -- {
  --   "brenoprata10/nvim-highlight-colors",
  --   event = "LazyFile",
  --   opts = {
  --     render = "virtual",
  --     virtual_symbol = "",
  --     virtual_symbol_position = "inline",
  --     enable_tailwind = true,
  --     exclude_filetypes = { "lazy", "noice" },
  --     exclude_buftypes = { "nofile" },
  --   },
  --   init = function()
  --     if vim.fn.has("nvim-0.12") == 1 then
  --       vim.api.nvim_create_autocmd("LspAttach", {
  --         callback = function(args)
  --           vim.lsp.document_color.enable(false, args.buf)
  --         end,
  --       })
  --     end
  --   end,
  -- },
  -- {
  --   "nvim-highlight-colors",
  --   opts = function()
  --     local highlight_colors = require("nvim-highlight-colors")
  --     ---@module "snacks"
  --     Snacks.toggle({
  --       name = "Highlight Colors",
  --       get = function()
  --         return highlight_colors.is_active()
  --       end,
  --       set = function(state)
  --         if state then
  --           highlight_colors.turnOn()
  --         else
  --           highlight_colors.turnOff()
  --         end
  --       end,
  --     }):map("<leader>uH")
  --   end,
  -- },
  {
    "catgoose/nvim-colorizer.lua",
    event = "LazyFile",
    opts = {
      filetypes = { "*", "!lazy", "!noice" },
      buftypes = { "!nofile" },
      lazy_load = true,
      user_default_options = {
        names = false,
        mode = "virtualtext",
        virtualtext = "",
        virtualtext_inline = "before",
        tailwind = "lsp",
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          vim.lsp.document_color.enable(false, args.buf)
        end,
      })
    end,
  },
  {
    "nvim-colorizer.lua",
    opts = function()
      local colorizer = require("colorizer")
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
