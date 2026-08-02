--[[
Neogit: Magit-style Git interface for Neovim.

Opens a status buffer in a vertical split. Stage, commit, branch,
log, and more — all from a single buffer with single-key commands.

Keybindings:
  <leader>gs   Open Neogit status (split)
  <leader>gl   Open Neogit log

Inside the status buffer, Neogit uses its own keybindings (like magit).
Press ? inside Neogit to see them.

KNOWN BUGS (latest Neogit, July 2026):
  - s key may not stage during rebase conflicts (issues #1887, #1621)
    Workaround: use <C-s> to stage, or stage inside Diffview
  - Interactive rebase commit picker may vanish (issue #1859)
    Workaround: use :Git rebase --continue from command line

diffview integration disabled — when enabled, s opens Diffview instead
of staging directly. Re-enable if you prefer staging via Diffview.
--]]
return {
  'NeogitOrg/neogit',
  cmd = 'Neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
    'nvim-telescope/telescope.nvim',
  },
  keys = {
    { '<leader>gs', '<cmd>Neogit<CR>', desc = 'Git status' },
    { '<leader>gl', '<cmd>Neogit log<CR>', desc = 'Git log' },
  },
  opts = {
    kind = 'split',
    -- diffview disabled: known to steal s key for staging (issue #1621).
    -- Re-enable if you prefer staging via Diffview (s → opens diff, close → staged).
    integrations = { telescope = true, diffview = false },
  },
}
