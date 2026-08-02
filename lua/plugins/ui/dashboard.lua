-- alpha-nvim: Dashboard / startup screen
--
-- Shows ASCII art header + quick-action buttons when nvim starts with no file.
--
-- ASCII art uses Lua long-bracket strings ([[ ... ]]) so backslashes are
-- literal — no escaping needed. Each line is one string in header.val.
--
-- Buttons:
--   f  Find files     (Telescope find_files)
--   r  Recent files   (Telescope oldfiles)
--   p  Projects       (Telescope projects)
--   n  Obsidian notes (cd to vault + Telescope)
--   c  Config         (open ~/.config/nvim/)
--   q  Quit           (:qa)
return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    -- ASCII art header — each line is a [[ literal string ]]
    -- Backslashes are literal in [[ ]], no \\ needed
    dashboard.section.header.val = {
      [[      ___                                     ___                                     ___     ]],
      [[     /\__\                     _____         /\  \                      ___          /\  \    ]],
      [[    /:/ _/_       ___         /::\  \        \:\  \       ___          /\  \        |::\  \   ]],
      [[   /:/ /\  \     /\__\       /:/\:\  \        \:\  \     /\__\         \:\  \       |:|:\  \  ]],
      [[  /:/ /::\  \   /:/__/      /:/  \:\__\   _____\:\  \   /:/__/          \:\  \    __|:|\:\  \ ]],
      [[ /:/_/:/\:\__\ /::\  \     /:/__/ \:|__| /::::::::\__\ /::\  \      ___  \:\__\  /::::|_\:\__\]],
      [[ \:\/:/ /:/  / \/\:\  \__  \:\  \ /:/  / \:\~~\~~\/__/ \/\:\  \__  /\  \ |:|  |  \:\~~\  \/__/]],
      [[  \::/ /:/  /   ~~\:\/\__\  \:\  /:/  /   \:\  \        ~~\:\/\__\ \:\  \|:|  |   \:\  \      ]],
      [[   \/_/:/  /       \::/  /   \:\/:/  /     \:\  \          \::/  /  \:\__|:|__|    \:\  \     ]],
      [[     /:/  /        /:/  /     \::/  /       \:\__\         /:/  /    \::::/__/      \:\__\    ]],
      [[     \/__/         \/__/       \/__/         \/__/         \/__/      ~~~~           \/__/    ]],
    }

    -- Quick-action buttons
    dashboard.section.buttons.val = {
      dashboard.button('f', '  Find file', ':Telescope find_files<CR>'),
      dashboard.button('r', '  Recent files', ':Telescope oldfiles<CR>'),
      dashboard.button('p', '  Projects', ':Telescope projects<CR>'),
      dashboard.button('n', '  Notes (Obsidian)', ':cd /mnt/c/Users/sidne/Desktop/Notes/Obsidian | :Telescope find_files<CR>'),
      dashboard.button('c', '  Config', ':e ~/.config/nvim/<CR>'),
      dashboard.button('q', '  Quit', ':qa<CR>'),
    }

    alpha.setup(dashboard.opts)
  end,
}
