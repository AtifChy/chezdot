return {
  {
    "nvim-lspconfig",
    dependencies = { "b0o/SchemaStore.nvim" },
    opts = {
      servers = {
        jsonls = {
          before_init = function(_, config)
            config.settings.json.schemas =
              vim.tbl_deep_extend("force", config.settings.json.schemas or {}, require("schemastore").json.schemas())
          end,
        },
        yamlls = {
          before_init = function(_, config)
            config.settings.yaml.schemas =
              vim.tbl_deep_extend("force", config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
          end,
        },
      },
    },
  },
}
