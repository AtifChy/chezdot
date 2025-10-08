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
    ---@module "sidekick"
    ---@type sidekick.Config
    opts = {
      cli = {
        ---@type table<string, sidekick.cli.Tool|{}>
        tools = {
          copilot = {
            cmd = { "copilot" },
          },
          opencode = {
            cmd = { "opencode" },
            env = { OPENCODE_THEME = "catppuccin-macchiato" },
          },
        },
        win = {
          split = {
            width = math.floor(vim.o.columns * 0.4),
          },
          -- stylua: ignore
          keys = {
            stopinsert = { "<esc><esc>", "stopinsert", mode = "t" },
            nav_h = { "<C-h>", function() vim.cmd.wincmd("h") end, mode = "t" },
            nav_l = { "<C-l>", function() vim.cmd.wincmd("l") end, mode = "t" },
            nav_j = { "<C-j>", function() vim.cmd.wincmd("j") end, mode = "t" },
            nav_k = { "<C-k>", function() vim.cmd.wincmd("k") end, mode = "t" },
          },
        },
      },
    },
    keys = {
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>ao",
        function()
          require("sidekick.cli").toggle({ name = "opencode", focus = true })
        end,
        desc = "Sidekick OpenCode Toggle",
      },
    },
    init = function()
      vim.keymap.del("n", "<leader>ac")
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "sidekick_terminal",
        group = vim.api.nvim_create_augroup("local_sidekick_terminal", { clear = true }),
        callback = function()
          vim.keymap.set("t", "<C-/>", "<NOP>", { buffer = true })
          vim.keymap.set("t", "<C-_>", "<NOP>", { buffer = true })
        end,
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      -- remove sidekick lualine component
      table.remove(opts.sections.lualine_x, 2)
    end,
  },
}
