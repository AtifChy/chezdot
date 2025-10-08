---@module "lazy"
---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local lsp = vim.g.lazyvim_python_lsp or "pyrefly"

    local servers = {
      pyright = false,
      basedpyright = false,
      pyrefly = false,
    }

    if lsp == "pyrefly" then
      servers.pyrefly = {
        settings = {
          python = {
            pyrefly = {
              displayTypeErrors = "force-on",
            },
          },
        },
      }
    elseif lsp == "basedpyright" then
      servers.basedpyright = {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "strict",
            },
          },
        },
      }
    else
      servers.pyright = {}
    end

    opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, servers)

    return opts
  end,
}
