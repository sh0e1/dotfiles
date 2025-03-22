return {
  "williamboman/mason-lspconfig.nvim",
  version = "*",
  opts = {
    ensure_installed = {
      "bashls",
      "buf_ls",
      "dockerls",
      "gopls",
      "jsonls",
      "lua_ls",
      "prismals",
      "rust_analyzer",
      "sqlls",
      "terraformls",
      "ts_ls",
      "yamlls",
    }
  }
}
