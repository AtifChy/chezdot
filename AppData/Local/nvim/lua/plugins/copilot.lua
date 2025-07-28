return {
  "CopilotC-Nvim/CopilotChat.nvim",
  url = "https://github.com/AtifChy/CopilotChat.nvim",
  branch = "feat/make-windows-support",
  build = "make tiktoken",
  opts = {
    log_level = "warn",
    contexts = {
      diagnostics = {
        resolve = function()
          local diagnostics = vim.diagnostic.get(nil, { severity = nil })
          if vim.tbl_isempty(diagnostics) then
            return { { content = "Without diagnostics.", filetype = "text" } }
          end

          local lines = {}

          for _, d in ipairs(diagnostics) do
            table.insert(
              lines,
              string.format(
                "[%s] %s:%d:%d - %s",
                vim.diagnostic.severity[d.severity],
                vim.fn.bufname(d.bufnr),
                d.lnum + 1,
                d.col + 1,
                d.message
              )
            )
          end
          return {
            {
              content = table.concat(lines, "\n"),
              filename = "diagnostics.txt",
              filetype = "text",
            },
          }
        end,
      },
      keymaps = {
        description = "Show all globally defined keymaps",
        resolve = function()
          local maps = vim.api.nvim_get_keymap("n")
          local lines = {}

          for _, map in ipairs(maps) do
            table.insert(lines, string.format("%-10s -> %s [%s]", map.lhs, map.rhs or "", map.desc or ""))
          end

          return {
            {
              content = table.concat(lines, "\n"),
              filename = "keymaps.txt",
              filetype = "text",
            },
          }
        end,
      },
    },
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
