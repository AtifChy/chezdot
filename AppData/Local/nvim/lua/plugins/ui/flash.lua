return {
  "folke/flash.nvim",
  opts = {},
  keys = function(_, keys)
    return vim.tbl_filter(function(k)
      return not (k.desc and k.desc:match("Treesitter Incremental Selection"))
    end, keys)
  end,
}
