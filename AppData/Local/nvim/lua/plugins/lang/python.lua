return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = false,
        pyrefly = {
          settings = {
            python = {
              pyrefly = {
                displayTypeErrors = "force-on",
              },
            },
          },
        },
      },
    },
    init = function()
      vim.g.lazyvim_python_lsp = "pyrefly"
    end,
  },
}
