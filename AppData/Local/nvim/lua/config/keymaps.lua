-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

---@module "lazyvim"
---@module "snacks"

local map = vim.keymap.set

-- git
map("n", "<leader>gb", Snacks.picker.git_branches, { desc = "Git Branches" })
map("n", "<leader>gB", Snacks.picker.git_log_line, { desc = "Git Blame Line" })
map({ "n", "x" }, "<leader>gw", function()
  Snacks.gitbrowse()
end, { desc = "Git Browse (open)" })

-- Floating terminal
map("n", "<M-/>", function()
  Snacks.terminal(nil, { cwd = LazyVim.root(), win = { position = "float", border = vim.o.winborder } })
end, { desc = "Floating Terminal (Root Dir)" })
map("t", "<M-/>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- Title case
map("v", "gt", [[:s/\%V\v<(.)(\w*)/\u\1\L\2/g<CR>]], { desc = "Titlecase" })

-- Dismiss copilot inline completion
map("i", "<M-e>", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local completor = require("vim.lsp._capability").all["inline_completion"].active[bufnr]
  if completor then
    ---@diagnostic disable-next-line: undefined-field
    completor:abort()
  end
end, { desc = "Dismiss inline completion" })
