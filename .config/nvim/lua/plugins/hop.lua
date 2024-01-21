return {
  "smoka7/hop.nvim",
  version = "*",
  dependencies = {
    { "mfussenegger/nvim-treehopper" },
  },
  config = function()
    require("hop").setup()
  end,
}
