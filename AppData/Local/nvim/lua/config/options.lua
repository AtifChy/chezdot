-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

---@module "lazyvim.config"

local opt = vim.opt

opt.fileformats = "unix,dos"

opt.winborder = "rounded"
opt.expandtab = true
-- opt.spell = true
opt.spelloptions:prepend("camel")

opt.shell = "nu"
opt.shellcmdflag = "-c"
opt.shellquote = ""
opt.shellxquote = ""

-- lazyvim settings
vim.g.ai_cmp = false
-- vim.g.lazyvim_php_lsp = "intelephense"
vim.g.lazyvim_python_lsp = "ty"
vim.g.lazyvim_ts_lsp = "tsgo"
-- LazyVim.terminal.setup("pwsh")

-- Windows specific settings
local iswin32 = vim.fn.has("win32") == 1
if iswin32 then
  if vim.env.HOME == nil then
    vim.env.HOME = vim.env.USERPROFILE
  end
  if vim.env.USER == nil then
    vim.env.USER = vim.env.USERNAME
  end
end
