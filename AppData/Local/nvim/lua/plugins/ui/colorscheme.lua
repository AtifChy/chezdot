return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
      -- colorscheme = "kanagawa",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    ---@module "catppuccin"
    ---@class CatppuccinOptions
    opts = {
      flavour = "macchiato",
      auto_integrations = true,
      integrations = {
        bufferline = false,
        lsp_trouble = true,
        avante = {
          enabled = true,
          windows_sidebar_header_rounded = true,
        },
      },
      custom_highlights = function(colors)
        return {
          -- WinBarNC = { fg = colors.overlay0 },

          DiagnosticError = { style = false },
          DiagnosticWarn = { style = false },
          DiagnosticInfo = { style = false },
          DiagnosticHint = { style = false },
          DiagnosticOk = { style = false },

          SnacksPickerTitle = { fg = colors.pink, bg = colors.mantle },
          SnacksPickerPreviewTitle = { link = "SnacksPickerTitle" },
          SnacksNotifierTitleInfo = { link = "SnacksNotifierInfo" },
          SnacksNotifierTitleWarn = { link = "SnacksNotifierWarn" },
          SnacksNotifierTitleDebug = { link = "SnacksNotifierDebug" },
          SnacksNotifierTitleError = { link = "SnacksNotifierError" },
          SnacksNotifierTitleTrace = { link = "SnacksNotifierTrace" },

          GitSignsCurrentLineBlame = { link = "LspInlayHint" },

          NoiceCmdlineIcon = { fg = colors.lavender, style = false },
          NeogitSubtleText = { fg = colors.overlay0, style = false },

          TroubleNormal = { link = "NormalFloat" },
          TroubleIconField = { link = "WinBar" },

          AvanteSidebarNormal = { link = "Normal" },
        }
      end,
    },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
    },
  },
}
