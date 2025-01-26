return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-go",
    {
      "andythigpen/nvim-coverage",
      opts = {
        auto_reload = true,
      }
    }
  },
  keys = {
    {
      "<Leader>tt",
      function()
        require("neotest").run.run()
      end,
      desc = "Run the nearest test"
    },
    {
      "<Leader>T",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run the current file"
    },
    {
      "<Leader>tl",
      function()
        require("neotest").run.run_last()
      end,
      desc = "Re-run the last test that was run."
    },
    {
      "<Leader>td",
      function() require("neotest").run.run({ strategy = "dap" }) end,
      desc = "Debug the nearest test with dap"
    },
    {
      "<Leader>ts",
      function() require("neotest").summary.toggle() end,
      desc = "Toggle the test summary window"
    },
    {
      "<Leader>to",
      function() require("neotest").output_panel.toggle() end,
      desc = "Toggle the test output panel"
    },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-go")({
          args = { "-count=1", "-race" }
        })
      },
      icons = {
        child_indent = "|",
        child_prefix = "|",
        collapsed = "-",
        expanded = "+",
        failed = "X",
        final_child_indent = " ",
        final_child_prefix = "+",
        non_collapsible = "-",
        passed = "✓",
        running = "…",
        skipped = ">>",
        unknown = "?",
        watching = "∞",
      },
    })
  end,
}
