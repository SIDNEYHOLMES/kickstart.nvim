--[[
nvim-ts-autotag: Auto-rename closing HTML/JSX tags

When you edit an opening tag, the closing tag updates automatically.
Uses treesitter, so html parser must be installed (already in treesitter.lua).
--]]
return {
  'windwp/nvim-ts-autotag',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = {
    filetypes = {
      'html', 'javascript', 'javascriptreact',
      'typescript', 'typescriptreact',
      'markdown', 'xml',
      'cshtml', 'aspx', 'razor',
    },
  },
}
