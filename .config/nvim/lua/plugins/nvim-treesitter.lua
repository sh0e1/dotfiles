return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    { "nvim-treesitter/playground" },
  },
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = "all",
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]]"] = "@function.outer",
          },
          goto_previous_start = {
            ["[["] = "@function.outer",
          }
        },
      },
      playground = {
        enable = true,
      },
    }

    vim.api.nvim_set_hl(0, "@function.builtin", { link = "@function" })
    vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "@text" })
    vim.api.nvim_set_hl(0, "@text.diff.add", { link = "DiffAdd" })
    vim.api.nvim_set_hl(0, "@text.diff.change", { link = "DiffChange" })
    vim.api.nvim_set_hl(0, "@text.diff.delete", { link = "DiffDelete" })
    vim.api.nvim_set_hl(0, "@text.diff.text", { link = "DiffText" })
    vim.api.nvim_set_hl(0, "@diff.plus", { link = "DiffAdd" })
    vim.api.nvim_set_hl(0, "@diff.minus", { link = "DiffDelete" })
  end
}
