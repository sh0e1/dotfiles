return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "main",
    },
  },
  config = function()
    if vim.fn.executable("tree-sitter") == 1 then
      require("nvim-treesitter").install("stable")
    else
      vim.notify(
        "nvim-treesitter: `tree-sitter` CLI not on PATH; parsers will not install",
        vim.log.levels.WARN
      )
    end

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if not lang then return end
        local ok = pcall(vim.treesitter.start, args.buf, lang)
        if not ok then return end
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[0][0].foldmethod = "expr"
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
      },
      move = {
        set_jumps = true,
      },
    })

    local select = function(query)
      return function()
        require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
      end
    end
    vim.keymap.set({ "x", "o" }, "af", select("@function.outer"))
    vim.keymap.set({ "x", "o" }, "if", select("@function.inner"))
    vim.keymap.set({ "x", "o" }, "ac", select("@class.outer"))
    vim.keymap.set({ "x", "o" }, "ic", select("@class.inner"))

    vim.keymap.set({ "n", "x", "o" }, "]]", function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[[", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
    end)
  end,
}
