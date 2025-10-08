---@module "lazy.pkg.packspec"
---@type LazySpec[]
return {
  {
    "olimorris/codecompanion.nvim",
    enabled = false,
    -- event = "VeryLazy",
    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionChat",
      "CodeCompanionCmd",
      "CodeCompanionHistory",
      "CodeCompanionSummaries",
    },
    opts = {
      show_model_choices = true,
      strategies = {
        chat = {
          adapter = {
            name = "copilot",
            model = "gpt-5-mini",
          },
        },
        inline = {
          adapter = {
            name = "copilot",
            model = "gpt-5-mini",
          },
        },
      },
      display = {
        chat = {
          window = {
            width = 0.35,
            opts = {
              winfixwidth = true,
            },
          },
        },
      },
      memory = {
        opts = {
          chat = {
            enabled = true,
          },
        },
      },
      sources = {
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
      },
      extensions = {
        history = { enabled = true },
        -- vectorcode = {},
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
      -- "Davidyz/VectorCode",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "codecompanion" },
      },
      {
        "nvim-mini/mini.diff",
        config = function()
          local diff = require("mini.diff")
          diff.setup({
            -- Disabled by default
            source = diff.gen_source.none(),
          })
        end,
      },
      {
        "HakonHarnes/img-clip.nvim",
        opts = {
          filetypes = {
            codecompanion = {
              prompt_for_file_name = false,
              template = "[Image]($FILE_PATH)",
              use_absolute_path = true,
            },
          },
        },
      },
    },
    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>aa",
        ":CodeCompanionChat Add<CR>",
        desc = "Add to Chat (CodeCompanion)",
        mode = "v",
      },
      {
        "<leader>at",
        function()
          require("codecompanion").toggle()
        end,
        desc = "Toggle (CodeCompanion)",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        ":CodeCompanion<CR>",
        desc = "Inline Prompt (CodeCompanion)",
        mode = { "n", "v" },
      },
      {
        "<leader>ao",
        ":CodeCompanionActions<CR>",
        desc = "Open Actions (CodeCompanion)",
        mode = { "n", "v" },
      },
      {
        "<leader>an",
        "<Cmd>CodeCompanionChat<CR>",
        desc = "New Chat (CodeCompanion)",
        mode = { "n", "v" },
      },
      {
        "<leader>ad",
        ":CodeCompanion /doc<CR>",
        desc = "Add Documentation (CodeCompanion)",
        mode = { "n", "v" },
      },
      {
        "<leader>af",
        ":CodeCompanion /fix<CR>",
        desc = "Fix Code (CodeCompanion)",
        mode = { "n", "v" },
      },
      {
        "<leader>ae",
        ":CodeCompanion /explain<CR>",
        desc = "Explain Code (CodeCompanion)",
        mode = { "n", "v" },
      },
    },
    init = function()
      require("plugins.ai.codecompanion.extensions.noice").init()
    end,
  },
}
