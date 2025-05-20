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
            Normal       = { bg = "#000000", fg = "#e6e6e6" },
            NormalNC     = { bg = "#000000", fg = "#e6e6e6" },
            EndOfBuffer  = { bg = "#000000", fg = "#000000" }, -- Hide ~ tildes
            CursorLine   = { bg = "#111111" }, -- Optional: subtle highlight for current line
            LineNr       = { fg = "#666666" }, -- Optional: dim line numbers
            SignColumn   = { bg = "#000000" },

            -- Neo-tree sidebar
            NeoTreeNormal      = { bg = "#000000", fg = "#e6e6e6" },
            NeoTreeNormalNC    = { bg = "#000000", fg = "#e6e6e6" },
            NeoTreeEndOfBuffer = { bg = "#000000", fg = "#000000" },
            NeoTreeWinSeparator = { bg = "#000000", fg = "#000000" },

            ["@function"] = { fg = "#FFD700" },
            ["@function.call"] = { fg = "#FFD700" },
            ["@function.builtin"] = { fg = "#FFD700" }, -- e.g. std::move
            ["@method"] = { fg = "#FFD700" },           -- class methods
          }
        end,
    })

    vim.cmd.colorscheme 'catppuccin-mocha'
    vim.cmd.hi 'Comment gui=none'
  end,
}
