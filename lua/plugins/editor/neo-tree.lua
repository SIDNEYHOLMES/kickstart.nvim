--[[
neo-tree.nvim: File tree explorer

Toggles with <leader>e. Shows file tree in a sidebar window.

Key behavior:
  <CR>      Opens the selected file or expands/collapses directory
  <Space>   Disabled in neo-tree — falls through to global leader key handling.
            Press Space then another key for leader keybindings (e, b, f, etc.)

Settings:
  hide_dotfiles = false     Show .files (like .gitignore, .env)
  hide_gitignored = true    Hide files listed in .gitignore
--]]
return {
  'nvim-neo-tree/neo-tree.nvim',
  cmd = 'Neotree',
  keys = { { '<leader>e', '<cmd>Neotree toggle<CR>', desc = 'Toggle file tree' } },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  opts = {
    filesystem = {
      filtered_items = { hide_dotfiles = false, hide_gitignored = true },
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
    window = {
      mappings = {
        ['<Space>'] = 'none',
      },
    },
    -- Disable neo-tree's <Space> mapping so leader key works.
    -- <CR> opens files (default neo-tree behavior).
    -- NOTE: <Space> is mapped to <Nop> globally in keymaps.lua.
    -- which-key hooks into the keypress to show the leader popup.
  },
  config = function(_, opts)
    require('neo-tree').setup(opts)

    -- Refresh neo-tree git status when regaining focus (e.g. after git commit in terminal)
    vim.api.nvim_create_autocmd('FocusGained', {
      group = vim.api.nvim_create_augroup('neotree_refresh', { clear = true }),
      pattern = '*',
      callback = function()
        if package.loaded['neo-tree'] then
          pcall(vim.cmd, 'Neotree refresh')
        end
      end,
    })

    -- Open Neotree when nvim starts with a directory
    vim.api.nvim_create_autocmd('VimEnter', {
      group = vim.api.nvim_create_augroup('neotree_start', { clear = true }),
      pattern = '*',
      nested = true,
      once = true,
      callback = function()
        if vim.fn.argc() > 0 then
          local arg = vim.fn.argv(0)
          if vim.fn.isdirectory(arg) == 1 then
            vim.cmd('Neotree ' .. vim.fn.fnameescape(arg))
            -- Show dashboard on the right as decorative sidebar
            vim.schedule(function()
              vim.cmd 'wincmd l'
              pcall(vim.cmd.Alpha)
            end)
          end
        end
      end,
    })
  end,
}
