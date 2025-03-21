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
      { "<leader>ca", "<cmd>CopilotChat<cr>" },
    },
    opts = {
      window = {
        layout = 'float',
      },
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
        show_help = {
          normal = 'g?',
        },
      },
    },
  },
}
