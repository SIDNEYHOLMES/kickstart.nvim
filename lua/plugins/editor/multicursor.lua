return {
  "mg979/vim-visual-multi",
  branch = "master",
  init = function() vim.g.VM_default_mappings = 0 end,
  keys = {
    { "<C-n>",      "<Plug>(VM-Select-Cursor-Word)",  mode = "n", desc = "Select cursor word" },
    { "<M-C-Down>", "<Plug>(VM-Add-Cursor-Down)",     mode = "n", desc = "Add cursor down" },
    { "<M-C-Up>",   "<Plug>(VM-Add-Cursor-Up)",       mode = "n", desc = "Add cursor up" },
    { "<M-m>",      "<Plug>(VM-Toggle-Mappings)",     mode = "n", desc = "Toggle multi-cursor" },
  },
}
