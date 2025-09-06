-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "text",
    "diff",
    "toml*",
    "dockerfile",
    "make",
  },
  callback = function()
    vim.b.snacks_indent = false
  end,
})

vim.api.nvim_create_autocmd("UILeave", {
  callback = function()
    local data_dir = vim.fn.stdpath("data")
    local file = vim.fs.joinpath(data_dir, "shada", "main.shada.tmp.x")
    vim.uv.fs_unlink(file)
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match("^diffview:") then
      for _, client in pairs(vim.lsp.get_clients({ bufnr = bufnr })) do
        vim.defer_fn(function()
          vim.lsp.buf_detach_client(args.buf, client.id)
        end, 10)
      end
    end
  end,
})
