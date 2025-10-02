---@module "lazy.pkg.packspec"
---@type LazySpec[]
return {
  {
    "yetone/avante.nvim",
    url = "https://github.com/AtifChy/avante.nvim",
    branch = "feat/proper_desc",
    enabled = false,
    build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    event = "VeryLazy",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      -- optional
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
      {
        "saghen/blink.cmp",
        dependencies = {
          "Kaiser-Yang/blink-cmp-avante",
        },
        opts = {
          sources = {
            default = { "avante" },
            providers = {
              avante = {
                name = "avante",
                module = "blink-cmp-avante",
                opts = {
                  avante = {
                    command = {
                      get_kind_name = function(_)
                        return "AvanteCmd"
                      end,
                    },
                    mention = {
                      get_kind_name = function(_)
                        return "AvanteMention"
                      end,
                    },
                    shortcut = {
                      get_kind_name = function(_)
                        return "AvanteShortcut"
                      end,
                    },
                  },
                  kind_icons = {
                    AvanteCmd = " ",
                    AvanteMention = " ",
                    AvanteShortcut = " ",
                  },
                },
              },
            },
          },
        },
      },
    },
    ---@module "avante"
    ---@type avante.Config
    opts = {
      provider = "copilot",
      -- auto_suggestions_provider = "copilot",
      providers = {
        copilot = {
          model = "gpt-5-mini",
        },
      },
      windows = {
        wrap = true,
        edit = {
          border = vim.o.winborder,
        },
        ask = {
          border = vim.o.winborder,
        },
      },
      behaviour = {
        -- auto_set_keymaps = false,
        auto_approve_tool_permissions = false,
        new_option = true,
      },
      selector = {
        provider = "snacks",
      },
      input = {
        provider = "snacks",
      },
      file_selector = {
        provider = "snacks",
      },
    },
    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
    },
  },
}
