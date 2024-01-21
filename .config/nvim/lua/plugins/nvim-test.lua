return {
  "klen/nvim-test",
  keys = {
    { '<Leader>t', '<Cmd>TestNearest<CR>' },
    { '<Leader>T', '<Cmd>TestFile<CR>' },
    { '<Leader>a', '<Cmd>TestSuite<CR>' },
    { '<Leader>l', '<Cmd>TestLast<CR>' },
    { '<Leader>g', '<Cmd>TestVisit<CR>' },
  },
  cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit", "TestEdit", "TestInfo" },
  config = function()
    require("nvim-test").setup()
  end
}
