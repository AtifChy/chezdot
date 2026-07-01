return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "catppuccin-mocha",
      colorscheme = "kanagawa",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    ---@module "catppuccin"
    ---@type CatppuccinOptions
    opts = {
      background = {
        light = "latte",
        dark = "macchiato",
      },
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

            TreesitterContext = { link = "Normal" },
            TreesitterContextLineNumber = { link = "LineNr" },
          }
        end,
      },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    ---@module "kanagawa"
    ---@type KanagawaConfig
    opts = {
      compile = true,
      undercurl = true,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      ---@param colors KanagawaColors
      overrides = function(colors)
        return {
          TreesitterContext = { link = "Normal" },
          TreesitterContextLineNumber = { link = "LineNr" },
          TreesitterContextBottom = { sp = colors.theme.ui.nontext, underline = true },
          TreesitterContextLineNumberBottom = { link = "TreesitterContextBottom" },

          StatusLine = { bg = colors.theme.ui.bg_p1 },

          RenderMarkdownCode = { bg = colors.theme.ui.float.bg },
        }
      end,
    },
    init = function()
      vim.g.kanagawa_lualine_bold = true
    end,
  },
}
