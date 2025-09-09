-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- General
opt.expandtab = true
opt.spell = true
opt.spelloptions:prepend("camel")
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- opt.shell = "nu"
-- opt.shellcmdflag = "-c"
-- opt.shellquote = ""
-- opt.shellxquote = ""

-- LazyVim settings
vim.g.lazyvim_python_lsp = "pyrefly"

-- LazyVim.terminal.setup("pwsh")

-- Windows specific settings
if vim.fn.has("win32") == 1 then
  if vim.env.HOME == nil then
    vim.env.HOME = vim.env.USERPROFILE
  end
  if vim.env.USER == nil then
    vim.env.USER = vim.env.USERNAME
  end
end

-- vim.api.nvim_create_autocmd("ColorScheme", {
--   callback = function()
--     vim.api.nvim_set_hl(0, "LspReferenceTarget", {})
--   end,
-- })
