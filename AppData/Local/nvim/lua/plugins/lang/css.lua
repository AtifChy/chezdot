return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@type table<string, vim.lsp.Config|false>
      servers = {
        tailwindcss = {
          filetypes = { "css" },
          settings = {
            tailwindCSS = {
              classFunctions = { "cva", "cx" },
            },
          },
        },
        -- css_variables = {},
      },
    },
  },
}
