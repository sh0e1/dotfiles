local map = vim.api.nvim_set_keymap
local silent = { silent = true, noremap = true }

map('n', '<Leader>t', [[<Cmd>TestNearest<CR>]], silent)
map('n', '<Leader>T', [[<Cmd>TestFile<CR>]], silent)
map('n', '<Leader>a', [[<Cmd>TestSuite<CR>]], silent)
map('n', '<Leader>l', [[<Cmd>TestLast<CR>]], silent)
map('n', '<Leader>g', [[<Cmd>TestVisit<CR>]], silent)
