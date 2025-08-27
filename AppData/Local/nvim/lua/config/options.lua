-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- General
vim.o.expandtab = true
vim.o.spelloptions = "camel,noplainbuffer"

vim.o.shell = "nu"
vim.o.shellcmdflag = "-c"
vim.o.shellquote = ""
vim.o.shellxquote = ""

-- Windows specific settings
if vim.fn.has("win32") == 1 then
  if vim.env.HOME == nil then
    vim.env.HOME = vim.env.USERPROFILE
  end
  if vim.env.USER == nil then
    vim.env.USER = vim.env.USERNAME
  end
end

-- Set python lsp to pyrefly
vim.g.lazyvim_python_lsp = "pyrefly"

-- vim.api.nvim_create_autocmd("ColorScheme", {
--   callback = function()
--     vim.api.nvim_set_hl(0, "LspReferenceTarget", {})
--   end,
-- })
