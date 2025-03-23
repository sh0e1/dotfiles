return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.nvim',
  },
  ft = { 'markdown', 'copilot-chat' },
  opts = {
    completions = { lsp = { enabled = true } },
    sign = { enabled = false },
  },
}
