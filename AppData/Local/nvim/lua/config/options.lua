-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- General
vim.o.expandtab = true

vim.opt.shell = "nu"
vim.opt.shellcmdflag = "-c"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""

-- Windows specific settings
if vim.fn.has("win32") == 1 then
  vim.env.HOME = os.getenv("HOMEDRIVE") .. os.getenv("HOMEPATH")
end

-- Set python lsp to pyrefly
vim.g.lazyvim_python_lsp = "basedpyright"
