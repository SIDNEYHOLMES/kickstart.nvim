--[[
nvim-cmp: Completion engine

Triggers on InsertEnter. Shows a popup with completions from multiple sources.
Use Tab/Shift-Tab to navigate, Enter or Ctrl-y to confirm selection.

Sources (in priority order):
  nvim_lsp  - LSP server suggestions (variables, functions, etc.)
  luasnip   - Snippet expansion
  buffer    - Words from open buffers
  path      - File system paths

Key mappings:
  Ctrl-b/f     Scroll documentation popup
  Ctrl-Space   Manually trigger completion
  Ctrl-e       Close popup
  Ctrl-y       Confirm selection (standard vim completion key)
  Enter        Confirm selection
  Ctrl-n/p     Select next/prev item in popup
  Tab          Select next item, or expand snippet, or normal Tab
  Shift-Tab    Select prev item, or jump back in snippet

NOTE: select = false means you must explicitly pick an item before confirming.
This prevents accidental selections when typing fast.
--]]
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",       -- LSP completion capabilities
    "hrsh7th/cmp-buffer",          -- words from open buffers
    "hrsh7th/cmp-path",            -- file system paths
    "hrsh7th/cmp-nvim-lua",        -- nvim Lua API completions
    "L3MON4D3/LuaSnip",            -- snippet engine
    "saadparwaiz1/cmp_luasnip",    -- luasnip source for cmp
    "rafamadriz/friendly-snippets", -- snippet collection
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- Load VS Code-style snippets from friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      -- How to expand snippets sent by LSP servers
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      -- Key mappings for the completion popup
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-y>"] = cmp.mapping.confirm({ select = false }),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        -- Tab: navigate popup, expand snippet, or normal Tab
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        -- Shift-Tab: navigate popup backward, or jump back in snippet
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      -- Completion sources in priority order
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end,
}
