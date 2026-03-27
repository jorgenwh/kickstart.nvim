return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      transparent_background = false,
        custom_highlights = function(colors)
          return {
            -- Editor main window
            Normal       = { bg = "#0e1415", fg = "#e6e6e6" },
            NormalNC     = { bg = "#0e1415", fg = "#e6e6e6" },
            EndOfBuffer  = { bg = "#0e1415", fg = "#0e1415" }, -- Hide ~ tildes
            CursorLine   = { bg = "#1a2122" }, -- Optional: subtle highlight for current line
            LineNr       = { fg = "#666666" }, -- Optional: dim line numbers
            SignColumn   = { bg = "#0e1415" },

            -- Neo-tree sidebar
            NeoTreeNormal      = { bg = "#0e1415", fg = "#e6e6e6" },
            NeoTreeNormalNC    = { bg = "#0e1415", fg = "#e6e6e6" },
            NeoTreeEndOfBuffer = { bg = "#0e1415", fg = "#0e1415" },
            NeoTreeWinSeparator = { bg = "#0e1415", fg = "#0e1415" },

            -- Sidekick terminal pane
            SidekickNormal = { bg = "#0e1415", fg = "#e6e6e6" },
          }
        end,
    })

    vim.cmd.colorscheme 'catppuccin-mocha'
    vim.cmd.hi 'Comment gui=none'

    -- Apply custom syntax highlights
    require('custom_highlights').apply()
  end,
}
