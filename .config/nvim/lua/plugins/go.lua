return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
  },
  ft = { "go", "gomod" },
  event = { "CmdlineEnter" },
  config = function()
    require("go").setup({
      goimports = 'gopls',
      fillstruct = 'gopls',
      gofmt = 'gopls',
      lsp_cfg = false,
      gopls_remote_auto = true,
      dap_debug = false,
      dap_debug_keymap = false,
      dap_debug_gui = false,
      dap_debug_vt = false,
      textobjects = true,
      test_runner = 'go',
      verbose_tests = true,
    })
  end
}
