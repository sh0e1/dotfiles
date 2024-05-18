return {
  "projekt0n/github-nvim-theme",
  tag = "v0.0.7",
  priority = 1000,
  config = function()
    require("github-theme").setup({
      theme_style = "dimmed",
      keyword_style = "NONE",
      dark_float = true,
      overrides = function(c)
        return {
          Type = { fg = c.fg },
          SpellBad = {},
          SpellCap = { link = SpellBad },
          ["@type"] = { link = Type },
          ["@field"] = { fg = c.bright_blue },
          ["@property"] = { fg = c.bright_blue },
          ["@operator"] = { fg = c.bright_blue },
          ["@string.escape"] = { fg = c.syntax.string },
        }
      end
    })

    -- (nvim >= 0.10) the column separating vertically split windows
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#444c56" })
  end
}
