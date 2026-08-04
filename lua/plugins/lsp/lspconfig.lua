--[[
nvim-lspconfig: LSP keybindings

This file only handles LspAttach keybindings — the mappings that
become available when LSP attaches to a buffer.

Server installation and setup is handled in mason-lspconfig.lua.

Keybindings (buffer-local, only when LSP is active):
  gd           Go to definition
  gr           Find references
  K            Hover documentation
  <leader>rn   Rename symbol
  <leader>ca   Code action
  [d           Previous diagnostic
  ]d           Next diagnostic
--]]
return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local map = function(keys, func, desc) vim.keymap.set('n', keys, func, { buffer = ev.buf, desc = desc }) end
        map('gd', vim.lsp.buf.definition, 'Go to definition')
        map('gr', vim.lsp.buf.references, 'References')
        map('K', vim.lsp.buf.hover, 'Hover')
        map('<leader>rn', vim.lsp.buf.rename, 'Rename')
        map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
        map('[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
        map(']d', vim.diagnostic.goto_next, 'Next diagnostic')
        map('<leader>q', vim.diagnostic.open_float, 'Show diagnostic error')
      end,
    })
  end,
}
