return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<CR>', desc = 'Find files' },
    { '<leader>fg', '<cmd>Telescope live_grep<CR>', desc = 'Live grep' },
    { '<leader>fb', '<cmd>Telescope buffers<CR>', desc = 'Buffers' },
    { '<leader>fh', '<cmd>Telescope help_tags<CR>', desc = 'Help tags' },
    { '<leader>fp', '<cmd>Telescope projects<CR>', desc = 'Projects' },
  },
  opts = {
    defaults = { file_ignore_patterns = { 'node_modules', '.git/' } },
    extensions = { fzf = {} },
  },
  config = function(_, opts)
    require('telescope').setup(opts)
    pcall(function() require('telescope').load_extension 'fzf' end)
  end,
}
