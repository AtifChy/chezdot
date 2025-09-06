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
        lsp_trouble = true,
      },
      custom_highlights = function(colors)
        return {
          DiagnosticError = { style = false },
          DiagnosticWarn = { style = false },
          DiagnosticInfo = { style = false },
          DiagnosticHint = { style = false },
          DiagnosticOk = { style = false },

          SnacksPickerTitle = { fg = colors.pink, bg = colors.mantle },
          SnacksPickerPreviewTitle = { link = "SnacksPickerTitle" },
          GitSignsCurrentLineBlame = { link = "LspInlayHint" },
          NoiceCmdlineIcon = { fg = colors.lavender, style = false },
          NeogitSubtleText = { fg = colors.overlay0, style = false },

          TroubleNormal = { link = "NormalFloat" },
          TroubleIconField = { link = "WinBar" },
        }
      end,
    },
  },
}
