return {
  '3rd/image.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    backend = 'kitty',
    processor = 'magick_cli', -- use CLI instead of lua rock if needed
    integrations = {
      markdown = {
        enabled = true,
      },
    },
    max_height_window_percentage = 50,
    window_overlap_clear_enabled = true,
    hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp' },
  },
  event = 'VeryLazy',
  keys = {
    {
      '<leader>io',
      function()
        local file = vim.fn.expand('%:p')
        vim.fn.jobstart({ 'imv', file }, { detach = true })
      end,
      desc = 'Open image in imv',
    },
  },
}
