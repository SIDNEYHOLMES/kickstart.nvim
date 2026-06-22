-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

-- NOTE: plenary.nvim and nvim-web-devicons are already added by
-- plugins/telescope.lua and plugins/ui.lua respectively.
vim.pack.add {
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  'https://github.com/MunifTanjim/nui.nvim',
}

vim.keymap.set('n', '\\', '<Cmd>Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })

require('neo-tree').setup {
  filesystem = {
    filtered_items = {
	  visible = true,
	  show_hidden_count = true,
	  hide_dotfiles = false,
	  hide_gitignored = true,
	  hide_by_name = {
	   -- '.git',
	   -- '.DS_Store',
	   -- 'thumbs.db',
	 },
    never_show = {}
  },
    window = {
      mappings = {
        ['\\'] = 'close_window',
      },
    },
  },
}
