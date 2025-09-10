return {
  "olimorris/codecompanion.nvim",
  cmd = { "CodeCompanionGitCommit" },
  dependencies = { "jinzhongjia/codecompanion-gitcommit.nvim" },
  opts = {
    extensions = {
      gitcommit = {
        callback = "codecompanion._extensions.gitcommit",
        opts = {
          adapter = "copilot",
          model = "gpt-4.1",
          languages = { "English" },

          buffer = {
            enabled = true,
            auto_generate = true,
          },

          add_slash_command = true,

          use_commit_history = true,
          commit_history_count = 5,
        },
      },
    },
  },
  keys = {
    {
      "<leader>ag",
      "<Cmd>CodeCompanionGitCommit<CR>",
      desc = "Git Commit Message (CodeCompanion)",
      mode = { "n", "v" },
    },
  },
}
