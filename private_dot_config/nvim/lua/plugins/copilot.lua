return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      copilot_model = "gpt-4o-copilot",
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "copilot-chat" },
        },
      },
    },
    build = "make tiktoken",
    opts = function(_, opts)
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)

      local options = {
        log_level = "warn",
        headers = {
          user = "##   " .. user .. " ",
          assistant = "##   Copilot ",
          tool = "## 󱁤  Tool ",
        },
        mappings = {
          reset = {
            insert = "<C-x>",
            normal = "<C-x>",
          },
        },
      }

      require("CopilotChat").setup(vim.tbl_extend("force", opts, options))
    end,
    config = function(_, opts)
      require("CopilotChat.config").providers.gemini = {
        prepare_input = require("CopilotChat.config.providers").copilot.prepare_input,
        prepare_output = require("CopilotChat.config.providers").copilot.prepare_output,

        get_headers = function()
          local api_key = assert(os.getenv("GEMINI_API_KEY"), "GEMINI_API_KEY env not set")
          return {
            Authorization = "Bearer " .. api_key,
            ["Content-Type"] = "application/json",
          }
        end,

        get_models = function(headers)
          local response, err =
            require("CopilotChat.utils.curl").get("https://generativelanguage.googleapis.com/v1beta/openai/models", {
              headers = headers,
              json_response = true,
            })

          if err then
            error("Failed to fetch Gemini models: " .. err)
          end

          return vim.tbl_map(function(model)
            local id = model.id:gsub("^models/", "")
            return {
              id = id,
              name = id,
              streaming = true,
              tools = true,
            }
          end, response.body.data)
        end,

        get_url = function()
          return "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions"
        end,
      }

      local chat = require("CopilotChat")

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      local current_file

      ---@return string id
      local function chat_id()
        local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
        local filepath

        if git_root and git_root ~= "" and vim.v.shell_error == 0 then
          filepath = git_root
        else
          filepath = vim.fn.getcwd()
        end

        if filepath == "" then
          return ("scratch_%s"):format(vim.api.nvim_get_current_buf())
        end

        ---@param s string
        ---@return string
        local function sanitize(s)
          -- make it windows/FS friendly
          s = s:gsub("[/\\:]", "_")
          s = s:gsub("[%c%z]", "")
          return s
        end

        return sanitize(filepath)
      end

      ---@return string path
      local function get_bucket()
        local id = chat_id()
        local bucket = vim.fs.joinpath(chat.config.history_path, id)
        if vim.fn.isdirectory(bucket) == 0 then
          vim.fn.mkdir(bucket, "p")
        end
        return bucket
      end

      local function save_chat()
        local bucket = get_bucket()
        local filename = tostring(os.date("%Y%m%d_%H%M%S"))

        if current_file and current_file ~= filename then
          local old_path = vim.fs.joinpath(bucket, current_file .. ".json")
          if vim.fn.filereadable(old_path) == 1 then
            vim.fn.delete(old_path)
          end
        end

        chat.save(filename, bucket)
        vim.notify("Chat history saved: " .. filename, vim.log.levels.INFO, { title = "CopilotChat" })

        current_file = filename
      end

      ---Convert a timestamp difference to a human-readable relative time
      ---@param diff integer Unix timestamp difference in seconds
      ---@param max_days integer Maximum number of days to show relative time for
      ---@return string?
      local function format_relative_time(diff, max_days)
        local seconds_in_day = 24 * 60 * 60

        if diff > max_days * seconds_in_day then
          return nil
        end

        local function plural(n, unit)
          return n .. " " .. (n == 1 and unit or unit .. "s")
        end

        local parts = {}

        local days = math.floor(diff / seconds_in_day)
        if days > 0 then
          table.insert(parts, plural(days, "day"))
        end
        diff = diff % seconds_in_day

        local hours = math.floor(diff / 3600)
        if hours > 0 then
          table.insert(parts, plural(hours, "hour"))
        end
        diff = diff % 3600

        local minutes = math.floor(diff / 60)
        if minutes > 0 then
          table.insert(parts, plural(minutes, "minute"))
        end
        diff = diff % 60

        if #parts <= 1 then
          table.insert(parts, plural(diff, "second"))
        end

        return table.concat(parts, ", ") .. " ago"
      end

      local function load_chat()
        local bucket = get_bucket()
        local files = vim.fn.globpath(bucket, "*.json", false, true)
        if not files or vim.tbl_isempty(files) then
          vim.notify("No chat history found", vim.log.levels.WARN, { title = "CopilotChat" })
        end

        ---@param filename string
        ---@return string
        local format_datetime_label = function(filename)
          local date, time = filename:match("^(%d%d%d%d%d%d%d%d)%_(%d%d%d%d%d%d)%.json$")
          if not date or not time then
            return filename
          end

          ---@type osdateparam
          local t = {
            year = date:sub(1, 4),
            month = date:sub(5, 6),
            day = date:sub(7, 8),
            hour = time:sub(1, 2),
            min = time:sub(3, 4),
            sec = time:sub(5, 6),
          }
          local filetime = os.time(t)
          local diff = os.difftime(os.time(), filetime)

          local relative = format_relative_time(diff, 3)
          if relative then
            return relative
          end

          return string.format(
            "%s %s",
            date:sub(1, 4) .. "-" .. date:sub(5, 6) .. "-" .. date:sub(7, 8),
            time:sub(1, 2) .. ":" .. time:sub(3, 4) .. ":" .. time:sub(5, 6)
          )
        end

        local items = {}
        for _, file in ipairs(files) do
          local name = vim.fs.basename(file)
          table.insert(items, {
            filename = name:gsub("%.json$", ""),
            label = format_datetime_label(name),
          })
        end

        table.sort(items, function(a, b)
          return a.filename > b.filename
        end)

        vim.ui.select(
          items,
          {
            prompt = "Select chat history to load",
            format_item = function(item)
              return item.label
            end,
          },
          ---@param choice { filename: string, label: string }
          function(choice)
            if not choice then
              return
            end

            local ok, err = pcall(chat.load, choice.filename, bucket)
            if ok then
              current_file = choice.filename
              vim.notify("Chat history loaded: " .. choice.filename, vim.log.levels.INFO, { title = "CopilotChat" })
              return
            end

            vim.notify("Failed to load chat history: " .. err, vim.log.levels.ERROR, { title = "CopilotChat" })
          end
        )
      end

      local function clear_chat()
        current_file = nil
        chat.reset()
      end

      vim.api.nvim_create_user_command("ChatSave", save_chat, {
        desc = "Save CopilotChat history",
      })

      vim.api.nvim_create_user_command("ChatLoad", load_chat, {
        desc = "Load CopilotChat history",
      })

      vim.api.nvim_create_user_command("ChatClear", clear_chat, {
        desc = "Clear CopilotChat",
      })

      chat.setup(opts)
    end,
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
        "<cmd>ChatSave<CR>",
        desc = "Save Chat History (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>al",
        "<cmd>ChatLoad<CR>",
        desc = "Load Chat History (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        "<cmd>ChatClear<CR>",
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },
    },
  },
}
