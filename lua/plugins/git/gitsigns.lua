--[[
Gitsigns.nvim: Inline git gutter signs and hunk operations.

Shows + / - / ~ signs next to line numbers for added, removed, and
changed lines. Provides hunk-level operations without leaving the buffer.

Keybindings:
  <leader>gS   Gitsigns sub-group (which-key popup)
    s          Stage hunk under cursor
    r          Reset hunk under cursor
    p          Preview hunk under cursor
    b          Blame line (inline)
    t          Toggle line highlights
  <leader>gb   Blame line (quick shortcut)

Navigation: Use built-in ]c / [c to jump between hunks.
--]]
return {
  'lewis6991/gitsigns.nvim',
  event = 'BufReadPost',
  keys = {
    { '<leader>gb', '<cmd>Gitsigns blame_line<CR>', desc = 'Blame line' },
    {
      '<leader>gS',
      function()
        require('which-key').show { keys = '<leader>gS', mode = 'n' }
      end,
      desc = 'Gitsigns',
    },
    { '<leader>gSs', '<cmd>Gitsigns stage_hunk<CR>', desc = 'Stage hunk' },
    { '<leader>gSr', '<cmd>Gitsigns reset_hunk<CR>', desc = 'Reset hunk' },
    { '<leader>gSp', '<cmd>Gitsigns preview_hunk<CR>', desc = 'Preview hunk' },
    { '<leader>gSb', '<cmd>Gitsigns blame_line<CR>', desc = 'Blame line' },
    { '<leader>gSt', '<cmd>Gitsigns toggle_current_line_blame<CR>', desc = 'Toggle line blame' },
  },
  opts = {
    signs = {
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    current_line_blame = true,
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'
      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end
      -- Navigation between hunks
      map(']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gitsigns.next_hunk() end)
        return '<Ignore>'
      end, 'Next hunk')
      map('[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gitsigns.prev_hunk() end)
        return '<Ignore>'
      end, 'Previous hunk')
    end,
  },
}
