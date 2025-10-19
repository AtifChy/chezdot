-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("lazyvim_wrap_spell", { clear = true }),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    if vim.tbl_contains({ "nofile", "prompt", "help" }, vim.bo.buftype) then
      return
    end
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("lazy_backdrop_fix", { clear = true }),
  pattern = "lazy_backdrop",
  callback = function(ctx)
    local win = vim.fn.win_findbuf(ctx.buf)[1]
    vim.api.nvim_win_set_config(win, { border = "none" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("snacks_no_indent", { clear = true }),
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

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_detach_diffview", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if not bufname:find("diffview:", 1, true) then
      return
    end
    for _, client in pairs(vim.lsp.get_clients({ bufnr = bufnr })) do
      vim.defer_fn(function()
        vim.lsp.buf_detach_client(args.buf, client.id)
      end, 10)
    end
  end,
})

-- vim.api.nvim_create_autocmd("ColorScheme", {
--   callback = function()
--     vim.api.nvim_set_hl(0, "LspReferenceTarget", {})
--   end,
-- })
