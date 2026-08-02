return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      mode = 'buffers',
      numbers = 'ordinal',
      indicator = { style = 'underline' },
      separator_style = 'slant',
    },
  },
}
