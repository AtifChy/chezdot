return {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "LazyFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- ensure TS core is loaded first
  },
  opts = {
    max_lines = "15%",
    multiline_threshold = 1,
  },
  config = function(_, opts)
    local function h(name)
      return vim.api.nvim_get_hl(0, { name = name })
    end

    -- Set the highlight group for the context
    vim.api.nvim_set_hl(0, "TreesitterContext", { link = "Normal" })
    vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { fg = h("LineNr").fg, bg = h("Normal").bg })

    require("treesitter-context").setup(opts)
  end,
}
