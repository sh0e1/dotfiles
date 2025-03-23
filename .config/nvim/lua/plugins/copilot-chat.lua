return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    cmd = { "CopilotChat", "CopilotChatToggle" },
    keys = {
      { "<leader>ca", "<cmd>CopilotChatToggle<cr>", mode = 'n' },
      { "<leader>ca", "<cmd>CopilotChat<cr>",       mode = 'v' },
      { "<leader>cx", "<cmd>CopilotChatReset<cr>" },
    },
    opts = {
      insert_at_end = true,
      prompts = {
        Explain = {
          mapping = '<leader>ce',
          prompt = '選択したコードの説明を段落をつけて書いてください。',
          system_prompt = 'COPILOT_EXPLAIN'
        },
        Review = {
          mapping = '<leader>cr',
          prompt = '選択したコードを日本語でレビューしてください。',
          system_prompt = 'COPILOT_REVIEW'
        },
        Fix = {
          mapping = '<leader>cf',
          prompt = 'このコードには問題があります。問題を特定し、修正してコードを書き直してください。何が問題で、どのように変更したのかを説明してください。',
        },
        Optimize = {
          mapping = '<leader>co',
          prompt = '選択したコードを最適化し、パフォーマンスと可読性を向上させてください。最適化戦略と変更内容を説明してください。',
        },
        Docs = {
          mapping = '<leader>cd',
          prompt = '選択したコードにドキュメントコメントを追加してください。',
        },
        Tests = {
          mapping = '<leader>ct',
          prompt = '選択したコードのテストを書いてください。',
        },
        Commit = {
          mapping = '<leader>cc',
          prompt = 'コミットメッセージをタイトルのみ記述してください。',
        }
      },
      mappings = {
        reset = {
          normal = 'gx',
          insert = 'gx',
        },
        show_help = {
          normal = 'g?',
        },
      },
      -- Configuration options for rendering Markdown
      -- https://github.com/CopilotC-Nvim/CopilotChat.nvim/wiki/Examples-and-Tips#markdown-rendering
      highlight_headers = false,
      separator = '---',
      error_header = '> [!ERROR] Error',
    },
  },
}
