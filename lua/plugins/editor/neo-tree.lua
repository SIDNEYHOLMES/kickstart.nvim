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
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  keys = { { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle file tree" } },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    filesystem = {
      filtered_items = { hide_dotfiles = false, hide_gitignored = true },
    },
    -- Disable neo-tree's <Space> mapping so leader key works.
    -- <CR> opens files (default neo-tree behavior).
    -- NOTE: <Space> is mapped to <Nop> globally in keymaps.lua.
    -- which-key hooks into the keypress to show the leader popup.
    mappings = {
      ["<Space>"] = false,
      ["<CR>"] = "open",
    },
  },
}
