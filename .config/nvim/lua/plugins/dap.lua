return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "theHamsta/nvim-dap-virtual-text",
      config = function()
        require("nvim-dap-virtual-text").setup()
      end
    },
    {
      "leoluz/nvim-dap-go",
      config = function()
        require("dap-go").setup()
      end
    }
  },
}
