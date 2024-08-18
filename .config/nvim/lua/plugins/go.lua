return {
  "ray-x/go.nvim",
  ft = { "go", "gomod" },
  event = { "CmdlineEnter" },
  config = function()
    require("go").setup({
      goimports = 'gopls',
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
