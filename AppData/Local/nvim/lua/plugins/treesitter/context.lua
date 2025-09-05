return {
  "nvim-treesitter/nvim-treesitter-context",
  lazy = true,
  event = function()
    return {}
  end,
  opts = {
    max_lines = "15%",
    multiline_threshold = 1,
  },
  config = function(_, opts)
    -- Set the highlight group for the context
    vim.api.nvim_set_hl(0, "TreesitterContext", { link = "Normal" })
    vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { link = "LineNr" })

    require("treesitter-context").setup(opts)
  end,
}
