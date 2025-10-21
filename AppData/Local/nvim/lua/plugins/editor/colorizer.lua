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
      user_default_options = {
        names = false,
        mode = "virtualtext",
        virtualtext = "",
        virtualtext_inline = "before",
        tailwind = false,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("ColorizerAttach", { clear = true }),
        callback = function(args)
          local bufnr = args.buf
          vim.lsp.document_color.enable(true, bufnr, { style = "virtual" })

          local clients = vim.lsp.get_clients({ bufnr = bufnr })

          for _, client in pairs(clients) do
            if client.name == "jsonls" then break end

            if client:supports_method("textDocument/documentColor") then
              require("colorizer").detach_from_buffer(bufnr)
              break
            end
          end
        end,
      })
    end,
  },
  {
    "nvim-colorizer.lua",
    opts = function()
      local colorizer = require("colorizer")
      ---@module "snacks"
      Snacks.toggle({
        name = "Colorizer",
        get = function() return colorizer.is_buffer_attached() end,
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
