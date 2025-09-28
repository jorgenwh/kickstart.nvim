return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
    "DiffviewFileHistory",
  },
  keys = {
    { "<leader>df", "<cmd>DiffviewOpen<cr>", desc = "Open diffview" },
    -- { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
  },
  config = function()
    local actions = require("diffview.actions")

    require("diffview").setup({
      use_icons = true,
      enhanced_diff_hl = true,
      show_help_hints = true,
      watch_index = true,
      keymaps = {
        view = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
        diff1 = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
        diff2 = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
        diff3 = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
        diff4 = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
        file_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
        file_history_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
        option_panel = {
          { "n", "q", actions.close, { desc = "Close panel" } },
        },
        help_panel = {
          { "n", "q", actions.close, { desc = "Close help" } },
        },
      },
    })
  end,
}
