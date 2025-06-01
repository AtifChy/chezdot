-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.wrap = true -- Enable line wrap

vim.o.title = true -- Enable window title
vim.o.titlestring = "%t - nvim" -- Set window title format

if vim.fn.has("win32") == 1 or (vim.fn.has("unix") == 1 and vim.fn.exists("$WSLENV") == 1) then
  if vim.fn.executable("sioyek.exe") == 1 then
    vim.g.vimtex_view_method = "sioyek"
    vim.g.vimtex_view_sioyek_exe = "sioyek.exe"
    vim.g.vimtex_callback_progpath = "wsl nvim"
  elseif vim.fn.executable("mupdf.exe") == 1 then
    vim.g.vimtex_view_method = "general"
    vim.g.vimtex_view_general_viewer = "mupdf.exe"
  elseif vim.fn.executable("SumatraPDF.exe") == 1 then
    vim.g.vimtex_view_method = "general"
    vim.g.vimtex_view_general_viewer = "SumatraPDF.exe"
  end
end
