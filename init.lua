-- Neovim configuration
-- Originally based on kickstart.nvim
--
-- Structure:
--   lua/config/options.lua     — core settings, keymaps, autocmds
--   lua/config/pack.lua        — vim.pack build hooks
--   lua/plugins/               — plugin configurations (one per file)
--   lua/kickstart/plugins/     — bundled example plugins
--   lua/custom                 - custom plugins and keymaps 

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

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  callback = function()
    vim.opt_local.expandtab = true   -- use spaces, not tabs
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- Custom user keymaps (multi cursor, move line)
require 'custom.keymaps'
-- vim: ts=2 sts=2 sw=2 et
