--[[
lazy.nvim: Plugin manager bootstrap

This file:
  1. Clones lazy.nvim if not already installed
  2. Adds it to the runtimepath
  3. Calls lazy.setup() which loads all plugins from lua/plugins/

Plugin specs are organized in lua/plugins/ by category:
  ui/       - Visual plugins (colorscheme, statusline, dashboard, etc.)
  editor/   - Editor enhancements (treesitter, telescope, neo-tree, etc.)
  lsp/      - LSP and completion (mason, lspconfig, cmp, etc.)
  lang/     - Language-specific (markdown, obsidian)
  git/      - Git integration (git-conflict)

NOTE: mapleader is set in keymaps.lua (loaded before this file).
--]]

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim — imports all plugin specs from lua/plugins/
require('lazy').setup {
  spec = {
    { import = 'plugins' },
  },
  install = { colorscheme = { 'habamax' } },
  checker = { enabled = true },
}
