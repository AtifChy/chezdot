return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = { ensure_installed = { "autotools_ls" } },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "make" } },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = { make = { "checkmake" } },
    },
  },
  {
    "Zeroth/makeit.nvim",
    url = "https://github.com/AtifChy/makeit.nvim",
    lazy = true,
    dependencies = { "stevearc/overseer.nvim" },
    config = function()
      local map = vim.keymap.set

      map("n", "<leader>cM", "", { desc = "make" })
      map("n", "<leader>cMo", "<cmd>MakeitOpen<cr>", { desc = "Open Makeit" })
      map("n", "<leader>cMr", "<cmd>MakeitRedo<cr>", { desc = "Redo Last Make" })
      map("n", "<leader>cMs", "<cmd>MakeitStop<cr>", { desc = "Stop Make" })
      map("n", "<leader>cMt", "<cmd>MakeitToggleResults<cr>", { desc = "Toggle Make Results" })

      require("makeit").setup({ picker = "snacks" })
    end,
    init = function()
      local loaded = false
      local function check()
        ---@module "lazyvim"
        if #LazyVim.root.detectors.pattern(0, { "GNUmakefile", "Makefile", "makefile" }) > 0 then
          require("lazy").load({ plugins = { "makeit.nvim" } })
          loaded = true
        end
      end
      check()
      vim.api.nvim_create_autocmd("DirChanged", {
        callback = function()
          if not loaded then
            check()
          end
        end,
      })
    end,
  },
  {
    "stevearc/overseer.nvim",
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
    },
  },
}
