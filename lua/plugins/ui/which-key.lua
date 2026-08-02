--[[
which-key.nvim: Keybinding popup help

When you press <leader> (Space) and wait, which-key shows all available
commands in a popup. It auto-discovers keybindings from their `desc`
attributes — no need to register individual mappings here.

Architecture (one source of truth):
  - keymaps.lua:         All global keybindings with `desc` attributes
  - Plugin files:        Plugin-specific keybindings with `desc` attributes
  - lsp/lspconfig.lua:   LSP keybindings with `desc` attributes
  - which-key.lua:       ONLY group prefixes (so "Leader" and "Buffer" labels show)

To add a new keybinding:
  1. Add it to keymaps.lua with a `desc` attribute
  2. which-key auto-discovers it — no changes needed here

To add a new group:
  1. Add the group prefix here (e.g., { "<leader>g", group = "Git" })
  2. Add individual mappings in keymaps.lua with `<leader>g` prefix
--]]
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    defaults = {
      mode = { "n", "v" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- Register leader prefix groups only.
    -- Individual keybindings are auto-discovered from their `desc` attributes.
    wk.add({
      { "<leader>", group = "Leader" },
      { "<leader>b", group = "Buffer" },
    })
  end,
}
