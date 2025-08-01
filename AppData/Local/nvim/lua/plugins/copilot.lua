return {
  "CopilotC-Nvim/CopilotChat.nvim",
  build = "make tiktoken",
  opts = {
    log_level = "warn",
  },
  keys = {
    {
      "<leader>am",
      function()
        require("CopilotChat").select_model()
      end,
      desc = "Select Model (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>as",
      function()
        local chat = require("CopilotChat")
        local history_path = chat.config.history_path
        local root = vim.fn.expand("%:p:h")
        local project_id = root:gsub("[/\\:]", "_")
        local chat_file = history_path .. "/" .. project_id .. ".json"

        if vim.fn.filereadable(chat_file) == 1 then
          vim.ui.select({ "Replace", "Cancel" }, { prompt = "Chat history exists. Replace?" }, function(choice)
            if choice == "Replace" then
              chat.save(project_id)
              vim.notify("Chat history replaced", vim.log.levels.INFO, { title = "CopilotChat" })
            else
              vim.notify("Chat history not saved", vim.log.levels.INFO, { title = "CopilotChat" })
            end
          end)
        else
          chat.save(project_id)
          vim.notify("Chat history saved", vim.log.levels.INFO, { title = "CopilotChat" })
        end
      end,
      desc = "Save Chat History (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>al",
      function()
        local chat = require("CopilotChat")
        local history_path = chat.config.history_path
        local root = vim.fn.expand("%:p:h")
        local project_id = root:gsub("[/\\:]", "_")
        local chat_file = history_path .. "/" .. project_id .. ".json"

        if vim.fn.filereadable(chat_file) == 1 then
          chat.load(project_id)
          vim.notify("Chat history loaded", vim.log.levels.INFO, { title = "CopilotChat" })
        else
          vim.notify("Chat history not found", vim.log.levels.WARN, { title = "CopilotChat" })
        end
      end,
      desc = "Load Chat History (CopilotChat)",
      mode = { "n", "v" },
    },
  },
}
