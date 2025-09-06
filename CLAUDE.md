# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Codebase Overview

This is a Neovim configuration based on kickstart.nvim, using Lua for configuration. The setup uses lazy.nvim as the plugin manager and follows a modular plugin architecture.

## Architecture

### Directory Structure
```
init.lua                 # Main entry point - core settings, keymaps, lazy.nvim bootstrap
lua/
├── plugins/            # Plugin configurations (auto-loaded by lazy.nvim)
│   ├── nvim_lspconfig.lua  # LSP server configurations with Mason
│   ├── nvim_cmp.lua        # Completion setup with LuaSnip
│   ├── telescope.lua       # Fuzzy finder configuration
│   └── ...                 # Other plugin configs
└── kickstart/
    └── plugins/        # Optional kickstart modules
        ├── lint.lua        # nvim-lint setup (markdown linting)
        ├── debug.lua       # DAP debugging configuration
        └── ...
ftplugin/              # Filetype-specific settings
├── javascript.lua     # JS/JSX settings
├── typescript.lua     # TS/TSX settings  
├── python.lua        # Python settings
└── c.lua            # C/C++ settings
```

### Plugin Loading
- Plugins are auto-loaded from `lua/plugins/` via `{ import = 'plugins' }` in init.lua
- Each plugin file returns a LazySpec table for lazy.nvim
- Optional kickstart modules can be enabled by uncommenting imports in init.lua

## Common Commands

### Neovim Configuration Management
- `:Lazy` - Open lazy.nvim UI for plugin management
- `:Lazy update` - Update all plugins
- `:Lazy sync` - Sync plugins with lazy-lock.json
- `:Mason` - Manage LSP servers, linters, formatters
- `:MasonInstall <tool>` - Install specific tool
- `:checkhealth` - Check Neovim and plugin health

### LSP Operations
- `gd` - Go to definition (Telescope)
- `gr` - Find references (Telescope)
- `gI` - Go to implementation (Telescope)
- `<leader>D` - Type definition (Telescope)
- `<leader>ds` - Document symbols (Telescope)
- `<leader>ws` - Workspace symbols (Telescope)
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions
- `K` - Hover documentation
- `gl` - Show line diagnostics (float)
- `<leader>q` - Open diagnostic quickfix list
- `<leader>th` - Toggle inlay hints

### File Navigation & Search
- `<leader>sf` - Search files (Telescope)
- `<leader>sg` - Search by grep (Telescope)
- `<leader>sw` - Search current word (Telescope)
- `<leader>s.` - Search recent files (Telescope)
- `<leader>sh` - Search help tags (Telescope)
- `<leader>sk` - Search keymaps (Telescope)
- `<leader>ss` - Search select Telescope builtin
- `<leader>sr` - Resume last search (Telescope)
- `<leader>s/` - Search in current buffer (Telescope)
- `<leader>sn` - Search Neovim config files

### Window Navigation
- `<C-h>` - Move to left window
- `<C-l>` - Move to right window  
- `<C-j>` - Move to lower window
- `<C-k>` - Move to upper window

### Git Integration
- `:Neogit` - Open Neogit interface
- `:DiffviewOpen` - Open diffview
- Gitsigns keymaps configured in gitsigns.lua

## Key Configuration Details

### LSP Servers (auto-installed via Mason)
- `clangd` - C/C++ (custom config with --query-driver flag)
- `pyright` - Python
- `ts_ls` - TypeScript/JavaScript
- `lua_ls` - Lua (configured for Neovim development)
- `stylua` - Lua formatter

### Current Plugin Status
- **Formatting**: Disabled (conform.nvim commented out in lua/plugins/conform.lua)
- **Linting**: Active only for Markdown via markdownlint (lua/kickstart/plugins/lint.lua)
- **Completion**: nvim-cmp with LuaSnip snippets
- **Debugging**: Available via DAP (lua/kickstart/plugins/debug.lua)

### Tab Settings
- Default: 4 spaces, expandtab enabled
- Overrides in ftplugin/:
  - JavaScript/TypeScript: 2 spaces
  - Python: 4 spaces (PEP 8)
  - C: tabs (noexpandtab)

### Custom Filetype
- `*.idcl` files recognized as 'idcl' filetype (configured in init.lua:131-135)

## Development Workflow

### Adding New Plugins
1. Create new file in `lua/plugins/` with LazySpec table
2. Run `:Lazy` to install
3. Commit changes including lazy-lock.json updates

### Modifying LSP Configuration
- LSP servers: Edit `servers` table in lua/plugins/nvim_lspconfig.lua:175
- LSP keymaps: Modify LspAttach autocmd in nvim_lspconfig.lua:47
- Diagnostic display: Adjust vim.diagnostic.config in nvim_lspconfig.lua:144

### Enabling Optional Features
- Formatting: Uncomment conform.nvim in lua/plugins/conform.lua
- Additional linting: Configure in lua/kickstart/plugins/lint.lua
- Debugging: Already configured in lua/kickstart/plugins/debug.lua

## Important Notes

- Leader key is Space (`<space>`)
- Relative line numbers and cursorline enabled
- Clipboard synced with system (unnamedplus)
- Swap files disabled for performance
- Sign column merged with number column
- Diagnostics virtual text disabled (use `gl` to view)