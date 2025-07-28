-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tmpl",
  callback = function(args)
    local fname = vim.fn.fnamemodify(args.file, ":t")

    local filetype = fname:match("%.([^%.]+)%.tmpl$")
    if not filetype then
      return
    end

    local ft = vim.filetype.match({ filename = "dummy." .. filetype })
    if ft then
      vim.bo.filetype = ft
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "text",
    "diff",
    "toml*",
    "dockerfile",
  },
  callback = function()
    vim.b.snacks_indent = false
  end,
})
