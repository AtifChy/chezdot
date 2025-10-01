vim.filetype.add({
  filename = {
    ["whkdrc"] = "whkd",
  },
})

local spec = {
  "nvim-treesitter/nvim-treesitter",
  optional = true,
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "TSUpdate",
      callback = function()
        require("nvim-treesitter.parsers").whkd = {
          install_info = {
            url = "https://github.com/LGUG2Z/tree-sitter-whkd",
            revision = "acfc989a13060deafb7366a68a25e48534db7a68",
            queries = "queries",
          },
          tier = 2,
        }
      end,
    })
  end,
  opts = {
    ensure_installed = { "whkd" },
  },
}

return spec
