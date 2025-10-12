-- COMMENTED OUT: Replaced with fzf-lua for better performance
return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = 'master',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Set Telescope colors to match your black background with subtle borders
    local cream = '#999999'  -- Darker gray border

    vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#000000', fg = '#e6e6e6' })
    vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = '#000000', fg = cream })
    vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = '#000000', fg = '#e6e6e6' })
    vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = '#000000', fg = cream })
    vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { bg = '#000000', fg = '#FFD700' })
    vim.api.nvim_set_hl(0, 'TelescopePreviewNormal', { bg = '#000000', fg = '#e6e6e6' })
    vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { bg = '#000000', fg = cream })
    vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { bg = '#000000', fg = '#FFD700' })
    vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', { bg = '#000000', fg = '#e6e6e6' })
    vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { bg = '#000000', fg = cream })
    vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { bg = '#000000', fg = '#FFD700' })

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      -- All the info you're looking for is in `:help telescope.setup()`

      defaults = {
        mappings = {
          -- i = { ['<c-enter>'] = 'to_fuzzy_refine' },
          n = { ['s'] = 'select_vertical' },
        },
      },
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })

    -- Custom live_grep with inline filtering: search | !ext1,ext2
    vim.keymap.set('n', '<leader>sg', function()
      local pickers = require('telescope.pickers')
      local finders = require('telescope.finders')
      local make_entry = require('telescope.make_entry')
      local conf = require('telescope.config').values

      pickers.new({}, {
        -- prompt_title = 'Live Grep (use | for filters: search | !exclude,include)',
        finder = finders.new_job(function(prompt)
          if not prompt or prompt == "" then
            return nil
          end

          -- Parse prompt: "search term | !ext1,ext2,ext3"
          local search_term = prompt
          local args = { 'rg', '--color=never', '--no-heading', '--with-filename',
                         '--line-number', '--column', '--smart-case' }

          local pipe_pos = prompt:find('|', 1, true)
          if pipe_pos then
            search_term = vim.trim(prompt:sub(1, pipe_pos - 1))
            local filters = vim.trim(prompt:sub(pipe_pos + 1))

            -- Parse filters: !ext for exclusion, ext for inclusion
            for filter in filters:gmatch('[^,]+') do
              filter = vim.trim(filter)
              if filter ~= "" then
                local is_exclusion = filter:match('^!')
                local ext = is_exclusion and filter:sub(2) or filter

                -- Add *. prefix if not present
                if not ext:match('^%*%.') and not ext:match('^%*') then
                  ext = '*.' .. ext
                end

                table.insert(args, '--glob')
                table.insert(args, is_exclusion and ('!' .. ext) or ext)
              end
            end
          end

          if search_term == "" then
            return nil
          end

          -- Add search term
          table.insert(args, '-e')
          table.insert(args, search_term)

          return args
        end, make_entry.gen_from_vimgrep({}), nil, nil),
        previewer = conf.grep_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end, { desc = '[S]earch by [G]rep' })

    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })

    vim.keymap.set('n', '<leader>s', function()
      builtin.oldfiles { initial_mode = 'normal' }
    end, { desc = '[S]earch Recent Files ("." for repeat)' })

    vim.keymap.set('n', '<leader>b', function()
      builtin.buffers { initial_mode = 'normal' }
    end, { desc = '[ ] Find existing buffers' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config', initial_mode = 'normal' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
