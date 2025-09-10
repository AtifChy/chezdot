-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- General
opt.expandtab = true
opt.spell = true
opt.spelloptions:prepend("camel")

opt.shell = "nu"
opt.shellcmdflag = "-c"
opt.shellquote = ""
opt.shellxquote = ""

-- LazyVim settings
-- LazyVim.terminal.setup("pwsh")

vim.api.nvim_create_user_command("TabWidth", function(opts)
  local width = tonumber(opts.args)
  if not width or width < 1 then
    vim.notify("Invalid width: " .. tostring(opts.args), vim.log.levels.ERROR)
    return
  end
  vim.opt_local.tabstop = width
  vim.opt_local.shiftwidth = width
  vim.opt_local.softtabstop = width
end, {
  desc = "Set tab width",
  nargs = 1,
  complete = function()
    return { "2", "4", "8" }
  end,
})

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
