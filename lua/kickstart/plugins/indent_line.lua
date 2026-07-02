-- VS Code-like indentation guides with scope highlighting
-- See `:help ibl`

---@module 'lazy'
---@type LazySpec
return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  ---@module 'ibl'
  ---@type ibl.config
  opts = {
    -- Show indentation guides on blank lines (VS Code behavior)
    indent = {
      char = '▏', -- VS Code uses a thin vertical bar
      -- Highlight the current scope/context line
      highlight = 'IblIndent',
    },
    -- Highlight the current indentation scope (like VS Code's active indent guide)
    scope = {
      enabled = true,
      show_start = true,
      show_end = false,
      highlight = 'IblScope',
    },
    -- Show whitespace characters (tabs, spaces) — VS Code-like
    whitespace = {
      remove_blankline_trail = true,
    },
  },
}
