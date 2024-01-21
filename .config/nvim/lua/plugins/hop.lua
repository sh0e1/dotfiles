return {
  "smoka7/hop.nvim",
  version = "*",
  dependencies = {
    {
      "mfussenegger/nvim-treehopper",
      config = function()
        vim.keymap.set('o', 'm', ':<C-U>lua require("tsht").nodes()<CR>', { silent = true })
        vim.keymap.set('x', 'm', ':lua require("tsht").nodes()<CR>', { noremap = true, silent = true })
      end
    },
  },
  config = function()
    require("hop").setup()

    local hop = require('hop')
    local directions = require('hop.hint').HintDirection
    vim.keymap.set('', 'f', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
    end, { remap = true })
    vim.keymap.set('', 'F', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
    end, { remap = true })
    vim.keymap.set('', 't', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
    end, { remap = true })
    vim.keymap.set('', 'T', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
    end, { remap = true })
    vim.keymap.set('n', 's', function()
      hop.hint_char2({ multi_windows = true })
    end, { remap = true })
    vim.keymap.set('v', 's', function()
      hop.hint_char2()
    end, { remap = true })
    vim.keymap.set('', '<Leader>L', function()
      hop.hint_lines()
    end, { remap = true })
    vim.keymap.set('n', '<Leader>L', function()
      hop.hint_lines({ multi_windows = true })
    end, { remap = true })
    vim.keymap.set('', '<Leader>w', function()
      hop.hint_words()
    end, { remap = true })
    vim.keymap.set('n', '<Leader>w', function()
      hop.hint_words({ multi_windows = true })
    end, { remap = true })
  end,
}
