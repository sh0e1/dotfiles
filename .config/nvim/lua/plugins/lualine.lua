return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require('lualine').setup {
      options = {
        theme = "auto",
        icons_enabled = false,
        section_separators = '',
        component_separators = '',
      },
      extensions = {
        'fern',
        'fzf',
        'fugitive',
      }
    }
  end
}
