return {
  {
    "Bekaboo/dropbar.nvim",
    event = "LspAttach",
    keys = {
      {
        "<leader>;",
        function()
          require("dropbar.api").pick()
        end,
        desc = "Select Buffer Symbols (dropbar)",
        mode = "n",
      },
      {
        "[;",
        function()
          require("dropbar.api").goto_context_start()
        end,
        desc = "Goto start of current context (dropbar)",
        mode = "n",
      },
      {
        "];",
        function()
          require("dropbar.api").select_next_context()
        end,
        desc = "Select next context (dropbar)",
        mode = "n",
      },
    },
    opts = function()
      local menu_utils = require("dropbar.utils.menu")

      -- Closes all the windows in the current dropbar.
      local function close()
        local menu = menu_utils.get_current()
        while menu and menu.prev_menu do
          menu = menu.prev_menu
        end
        if menu then
          menu:close()
        end
      end

      -- Expands the entry if possible.
      local function expand()
        local menu = menu_utils.get_current()
        if not menu then
          return
        end
        local row = vim.api.nvim_win_get_cursor(menu.win)[1]
        local component = menu.entries[row]:first_clickable()
        if component then
          menu:click_on(component, nil, 1, "l")
        end
      end

      return {
        bar = {
          enable = function(buf, win, _)
            if
              not vim.api.nvim_buf_is_valid(buf)
              or not vim.api.nvim_win_is_valid(win)
              or vim.fn.win_gettype(win) ~= ""
              or vim.wo[win].winbar ~= ""
              or vim.bo[buf].ft == "help"
              or vim.bo[buf].ft == "copilot-chat"
              or vim.bo[buf].ft == "codecompanion"
            then
              return false
            end

            local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(buf))
            if stat and stat.size > 1024 * 1024 then
              return false
            end

            return vim.bo[buf].ft == "markdown"
              or pcall(vim.treesitter.get_parser, buf)
              or not vim.tbl_isempty(vim.lsp.get_clients({
                bufnr = buf,
                method = vim.lsp.protocol.Methods.textDocument_documentSymbol,
              }))
          end,
        },
        menu = {
          preview = false,
          keymaps = {
            -- Navigate back to the parent menu.
            ["h"] = "<C-w>q",
            ["<Left>"] = "<C-w>q",
            ["l"] = expand,
            ["<Right>"] = expand,
            ["q"] = close,
            ["<Esc>"] = close,
          },
        },
      }
    end,
    init = function()
      vim.api.nvim_create_autocmd("BufWinEnter", {
        group = vim.api.nvim_create_augroup("DropbarDisableFloatWinbar", { clear = true }),
        callback = function()
          local win = vim.api.nvim_get_current_win()
          local config = vim.api.nvim_win_get_config(win)

          -- Check if the current window is floating
          if config.relative ~= "" then
            -- Disable winbar for any floating window
            vim.wo[win].winbar = ""
            vim.w[win].winbar_no_attach = true
          end
        end,
      })
    end,
  },
}
