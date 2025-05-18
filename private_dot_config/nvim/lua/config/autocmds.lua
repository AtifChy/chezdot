-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- fix cursor bug with windows terminal
vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  callback = function()
    vim.opt.guicursor = ""
    vim.fn.chansend(vim.v.stderr, "\x1b[ q")
  end,
})

-- fixed tabstop and shiftwidth for fish files
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "fish" },
--   callback = function()
--     vim.bo.tabstop = 4
--     vim.bo.shiftwidth = 4
--   end,
-- })

-- disable indent for toml files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "toml*" },
  callback = function()
    vim.b.snacks_indent = false
  end,
})
