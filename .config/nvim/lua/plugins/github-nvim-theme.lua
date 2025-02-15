return {
  "projekt0n/github-nvim-theme",
  lazy = false,
  priority = 1000,
  config = function()
    require("github-theme").setup({
      options = {
        styles = {
          comments = "italic",
          functions = 'NONE',
          keywords = 'NONE',
          variables = 'NONE',
          conditionals = 'NONE',
          constants = 'NONE',
          numbers = 'NONE',
          operators = 'NONE',
          strings = 'NONE',
          types = 'NONE',
        },
      },
      groups = {
        github_dark_dimmed = {
          Directory = { fg = 'palette.blue' }
        }
      }
    })

    vim.cmd('colorscheme github_dark_dimmed')
  end
}
