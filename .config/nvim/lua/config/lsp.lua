local manson = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }

  -- スニペット展開 (LSP では通常 `cmp` を使うので省略)

  -- <C-Space> で補完をトリガー
  vim.keymap.set("i", "<C-Space>", vim.lsp.buf.completion, opts)

  -- 診断の移動
  vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]g", vim.diagnostic.goto_next, opts)

  -- 定義ジャンプ
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

  -- スプリット / 垂直スプリットで定義を開く
  vim.keymap.set("n", "gs", "<cmd>split | lua vim.lsp.buf.definition()<CR>", opts)
  vim.keymap.set("n", "gv", "<cmd>vsplit | lua vim.lsp.buf.definition({ split = 'vertical' })<CR>", opts)

  -- K でドキュメント表示
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

manson.setup()
mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
})
