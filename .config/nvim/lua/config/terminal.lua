vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { silent = true, noremap = true })
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  pattern = '*',
  callback = function()
    vim.cmd('startinsert')
    vim.cmd('setlocal nonumber')
  end,
})
