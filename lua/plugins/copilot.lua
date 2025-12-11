return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = false, -- We'll handle this manually
          next = '<S-Tab>',
        },
      },
    }

    local suggestion = require 'copilot.suggestion'

    vim.keymap.set('i', '<Tab>', function()
      if suggestion.is_visible() then
        suggestion.accept()
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
      end
    end, { desc = 'Accept Copilot or insert tab' })
  end,
}
