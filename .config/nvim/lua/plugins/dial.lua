return {
  "monaqa/dial.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
  keys = {
    {
      "<C-a>",
      function()
        require("dial.map").manipulate("increment", "normal")
      end,
    },
    {
      "<C-x>",
      function()
        require("dial.map").manipulate("decrement", "normal")
      end,
    },
    {
      "g<C-a>",
      function()
        require("dial.map").manipulate("increment", "gnormal")
      end,
    },
    {
      "g<C-x>",
      function()
        require("dial.map").manipulate("decrement", "gnormal")
      end,
    },
    {
      "<C-a>",
      mode = 'v',
      function()
        require("dial.map").manipulate("increment", "visual")
      end,
    },
    {
      "<C-x>",
      mode = 'v',
      function()
        require("dial.map").manipulate("decrement", "visual")
      end,
    },
    {
      "g<C-a>",
      mode = 'v',
      function()
        require("dial.map").manipulate("increment", "gvisual")
      end,
    },
    {
      "g<C-x>",
      mode = 'v',
      function()
        require("dial.map").manipulate("decrement", "gvisual")
      end,
    },
  },
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group {
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.decimal_int,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%Y-%m-%d"],
        augend.date.alias["%Y年%-m月%-d日"],
        augend.date.alias["%m/%d"],
        augend.date.alias["%-m/%-d"],
        augend.date.alias["%H:%M:%S"],
        augend.date.alias["%H:%M"],
        augend.constant.alias.ja_weekday,
        augend.constant.alias.ja_weekday_full,
        augend.constant.alias.bool,
        augend.semver.alias.semver,
      },
      visual = {
        augend.integer.alias.decimal,
        augend.integer.alias.decimal_int,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%Y-%m-%d"],
        augend.date.alias["%Y年%-m月%-d日"],
        augend.date.alias["%m/%d"],
        augend.date.alias["%-m/%-d"],
        augend.date.alias["%H:%M:%S"],
        augend.date.alias["%H:%M"],
      }
    }
  end,
}
