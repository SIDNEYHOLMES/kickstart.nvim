-- Neovim configuration — modularized kickstart.nvim
--
-- This is the ACTIVE config that Neovim loads.
-- The original, unmodified kickstart.nvim init.lua is preserved in
-- init-kickstart.lua for reference (the full monolithic version with
-- all settings, lazy.nvim setup, and plugin configs in one file).
--
-- Structure:
--   lua/config/options.lua     — core settings, keymaps, autocmds
--   lua/config/pack.lua        — vim.pack build hooks
--   lua/plugins/               — plugin configurations (one per file)
--   lua/kickstart/plugins/     — bundled example plugins
--   lua/custom/                — your personal plugins, keymaps, options
--     lua/custom/options.lua   — custom settings & autocmds
--     lua/custom/keymaps.lua   — custom keybindings
--     lua/custom/plugins/      — custom plugin configs (auto-loaded)

require 'config.options'

-- Plugin manager build hooks (must run before plugin configs)
require 'config.pack'

-- Core UX plugins
require 'plugins.ui'

-- Search & navigation
require 'plugins.telescope'

-- LSP, Mason, language servers
require 'plugins.lsp'

-- Formatting
require 'plugins.conform'

-- Autocomplete & snippets
require 'plugins.blink'

-- Treesitter
require 'plugins.treesitter'

-- Kickstart example plugins (uncomment to enable, or remove)
-- NOTE: gitsigns is configured in kickstart/plugins/gitsigns.lua
require 'kickstart.plugins.debug'
require 'kickstart.plugins.indent_line'
require 'kickstart.plugins.lint'
require 'kickstart.plugins.autopairs'
require 'kickstart.plugins.neo-tree'
require 'kickstart.plugins.gitsigns'

-- Custom user plugins (webdev, etc.)
require 'custom.plugins'

-- Custom user options & autocmds
require 'custom.options'

-- Custom user keymaps (move line)
require 'custom.keymaps'
-- vim: ts=2 sts=2 sw=2 et
