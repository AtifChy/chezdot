return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
      -- colorscheme = "kanagawa",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    ---@module "catppuccin"
    ---@type CatppuccinOptions
    opts = {
      auto_integrations = true,
      integrations = {
        bufferline = false,
        lsp_trouble = true,
        avante = {
          enabled = true,
          windows_sidebar_header_rounded = true,
        },
      },
      highlight_overrides = {
        all = function(colors)
          ---@type table<string, { fg?: string, bg?: string, style?: CtpHighlightArgs|false, link?: string }>
          return {
            -- WinBarNC = { fg = colors.overlay0 },

            DiagnosticError = { style = false },
            DiagnosticWarn = { style = false },
            DiagnosticInfo = { style = false },
            DiagnosticHint = { style = false },
            DiagnosticOk = { style = false },

            TabLineSel = { fg = colors.teal, bg = colors.surface0 },
            TabLineFill = { fg = colors.overlay0, bg = colors.base },

            SnacksNormal = { link = "NormalFloat" },
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

            DropBarMenuHoverIcon = { link = "Special" },
            DropBarIconUISeparatorNC = { link = "WinBarNC" },
          }
        end,
      },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
      colors = {
        theme = {
          all = {
            ui = { bg_gutter = "none" },
          },
        },
      },
    },
  },
}
