return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      copilot_model = "gpt-4o-copilot",
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    keys = {
      {
        "<leader>as",
        function()
          return require("CopilotChat").save(vim.fn.expand("%:t"))
        end,
        desc = "Save (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>al",
        function()
          return require("CopilotChat").load(vim.fn.expand("%:t"))
        end,
        desc = "Load (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>am",
        function()
          return require("CopilotChat").select_model()
        end,
        desc = "Select Model (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ag",
        function()
          return require("CopilotChat").select_agent()
        end,
        desc = "Select Agent (CopilotChat)",
        mode = { "n", "v" },
      },
    },
  },
}
