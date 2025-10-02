return {
  {
    "zbirenbaum/copilot.lua",
    dependencies = {
      "folke/sidekick.nvim",
    },
  },
  {

    "folke/sidekick.nvim",
    optional = true,
    -- dependencies = {
    --   "saghen/blink.cmp",
    --   ---@module "blink-cmp"
    --   ---@type blink.cmp.Config
    --   opts = {
    --     keymap = {
    --       ["<Tab>"] = {
    --         function(cmp)
    --           if cmp.is_active() then
    --             return cmp.select_next()
    --           end
    --           if require("sidekick").nes_jump_or_apply() then
    --             return
    --           end
    --         end,
    --         "snippet_forward",
    --         "fallback",
    --       },
    --     },
    --   },
    -- },
    ---@module "sidekick"
    ---@type sidekick.Config
    opts = {
      cli = {
        ---@class sidekick.win.Opts
        win = {
          -- layout = "float",
          split = {
            width = 65,
          },
        },
        ---@type table<string, sidekick.cli.Tool.spec>
        tools = {
          copilot = {
            cmd = { "copilot" },
          },
        },
      },
    },
    keys = {
      {
        "<Tab>",
        function()
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>"
          end
        end,
        mode = { "n" },
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
    },
  },
}
