--[[
Diffview.nvim: Split-diff views for comparing branches, commits, and index.

Opens a tab or split with side-by-side diffs. Handles merge conflict
resolution with a 3-way split (ours / theirs / result).

Keybindings:
  <leader>gd   Open Diffview (compares current state against HEAD)

Inside Diffview, use its own keybindings. Press ? to see them.
Replaces git-conflict.nvim for merge conflict resolution.
--]]
return {
  'sindrets/diffview.nvim',
  cmd = 'DiffviewOpen',
  keys = {
    { '<leader>gd', '<cmd>DiffviewOpen<CR>', desc = 'Diffview' },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      merge_tool = {
        layout = 'diff3_mixed',
        disable_diagnostics = true,
      },
    },
  },
}
