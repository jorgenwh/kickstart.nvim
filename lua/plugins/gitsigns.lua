return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    signs = {
      add = { text = '┃', hl = 'GitSignsAdd' },
      change = { text = '┃', hl = 'GitSignsChange' },
      delete = { text = '_', hl = 'GitSignsDelete' },
      topdelete = { text = '‾', hl = 'GitSignsDelete' },
      changedelete = { text = '~', hl = 'GitSignsChange' },
      untracked = { text = '┆', hl = 'GitSignsAdd' },
    },
    signs_staged = {
      add = { text = '┃', hl = 'GitSignsAdd' },
      change = { text = '┃', hl = 'GitSignsChange' },
      delete = { text = '_', hl = 'GitSignsDelete' },
      topdelete = { text = '‾', hl = 'GitSignsDelete' },
      changedelete = { text = '~', hl = 'GitSignsChange' },
    },
    signs_staged_enable = true,
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = {
      follow_files = true,
    },
    auto_attach = true,
    attach_to_untracked = false,
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',
      delay = 0,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = 40000,
    preview_config = {
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
    },
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal({ ']c', bang = true })
        else
          gitsigns.nav_hunk('next')
        end
      end, { desc = 'Jump to next git [c]hange' })

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal({ '[c', bang = true })
        else
          gitsigns.nav_hunk('prev')
        end
      end, { desc = 'Jump to previous git [c]hange' })

      -- Actions
      map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
      map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
      map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
      map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
      map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
      map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
      map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
      map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
      map('n', '<leader>hD', function()
        gitsigns.diffthis('~')
      end, { desc = 'git [D]iff against last commit' })

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })

      -- Visual mode
      map('v', '<leader>hs', function()
        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, { desc = 'stage git hunk' })
      map('v', '<leader>hr', function()
        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, { desc = 'reset git hunk' })

      -- Toggles
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
      map('n', '<leader>td', gitsigns.toggle_deleted, { desc = '[T]oggle git show [d]eleted' })
    end,
  },
  config = function(_, opts)
    require('gitsigns').setup(opts)
    
    -- Set more vibrant, saturated colors for git signs
    vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#00FF00' })  -- Bright green
    vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#FFD700' })  -- Gold/bright yellow
    vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#FF0000' })  -- Bright red
    vim.api.nvim_set_hl(0, 'GitSignsAddNr', { fg = '#00FF00' })
    vim.api.nvim_set_hl(0, 'GitSignsChangeNr', { fg = '#FFD700' })
    vim.api.nvim_set_hl(0, 'GitSignsDeleteNr', { fg = '#FF0000' })
    vim.api.nvim_set_hl(0, 'GitSignsAddLn', { bg = '#003300' })
    vim.api.nvim_set_hl(0, 'GitSignsChangeLn', { bg = '#333300' })
    vim.api.nvim_set_hl(0, 'GitSignsDeleteLn', { bg = '#330000' })
    
    -- Make blame text more visible
    vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { fg = '#888888' })
  end,
}