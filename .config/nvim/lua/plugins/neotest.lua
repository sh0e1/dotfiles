local show_coverage = false
local function toggle_coverage()
  local coverage = require("coverage")
  show_coverage = not show_coverage
  coverage.load(show_coverage)
end

return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-jest",
    {
      "andythigpen/nvim-coverage",
      opts = {
        auto_reload = true,
        lang = {
          go = {
            coverage_file = vim.fn.getcwd() .. '/cover.out',
          }
        }
      }
    }
  },
  cmd = {
    "Neotest",
    "Coverage",
    "CoverageClear",
    "CoverageHide",
    "CoverageLoad",
    "CoverageShow",
    "CoverageSummary",
    "CoverageToggle",
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
      function()
        require("neotest").run.run({ strategy = "dap" })
      end,
      desc = "Debug the nearest test with dap"
    },
    {
      "<Leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle the test summary window"
    },
    {
      "<Leader>to",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Toggle the test output panel"
    },
    {
      "<Leader>tc",
      function()
        toggle_coverage()
      end,
      desc = "Toggle test coverage"
    },
    {
      "<Leader>tC",
      function()
        require("coverage").load()
        require("coverage").summary()
      end,
      desc = "Toggle test coverage"
    },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-go")({
          args = { "-count=1", "-race", "-coverprofile=" .. vim.fn.getcwd() .. "/cover.out" },
        }),
        require("neotest-jest")({
          jestCommand = "npm test --",
        }),
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
