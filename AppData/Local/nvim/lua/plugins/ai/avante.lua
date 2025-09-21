---@module "lazy.pkg.packspec"
---@type LazySpec
return {
  {
    "yetone/avante.nvim",
    build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
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
    },
    opts = {
      provider = "copilot",
      -- providers = {
      --   copilot = {
      --     model = "claude-sonnet-4",
      --   },
      -- },
      auto_suggestions_provider = "copilot",
      windows = {
        wrap = true,
      },
      behaviour = {
        -- auto_set_keymaps = false,
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
      use_absolute_path = function() end,
    },
    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
    },
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
}
