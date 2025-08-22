return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    ---@module "catppuccin"
    ---@class CatppuccinOptions
    opts = {
      auto_integrations = true,
      integrations = {
        bufferline = false,
      },
      custom_highlights = function(colors)
        return {
          SnacksPickerTitle = { fg = colors.pink, bg = colors.mantle },
          SnacksPickerPreviewTitle = { link = "SnacksPickerTitle" },
          SnacksInputTitle = { fg = colors.teal, style = {} },
          SnacksInputIcon = { link = "SnacksInputTitle" },
          GitSignsCurrentLineBlame = { link = "LspInlayHint" },
          NoiceCmdlineIcon = { fg = colors.blue, style = {} },
        }
      end,
    },
  },
}
