return {
  "ray-x/go.nvim",
  ft = { "go" },
  config = function()
    require("go").setup({
      disable_defaults = true,
      goimport = 'gopls',
      fillstruct = 'gopls',
      gofmt = 'gopls',
      lsp_cfg = false,
      gopls_remote_auto = true,
      textobjects = true,
      test_runner = 'go',
      verbose_tests = true,
    })
  end
}
