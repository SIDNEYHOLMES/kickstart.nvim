--[[
mason-lspconfig: LSP server installation + setup

SINGLE SOURCE OF TRUTH for all LSP servers.
Add new servers to the ensure_installed list below.

The handler function runs for each installed server and:
  1. Loads nvim-lspconfig for that server
  2. Attaches nvim-cmp completion capabilities
  3. Calls setup() with those capabilities

Language-specific LSP configs (like ts_ls for TypeScript) are
configured here rather than in separate files — keeps everything
in one place and avoids the broken pattern of per-language specs.

Dependencies:
  neovim/nvim-lspconfig     - LSP client configuration
  hrsh7th/cmp-nvim-lsp      - LSP completion capabilities for cmp
--]]
return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
  },
  opts = {
    -- List all LSP servers you want installed and configured
    ensure_installed = {
      "bashls",       -- Bash
      "cssls",        -- CSS
      "html",         -- HTML
      "lua_ls",       -- Lua (for nvim config)
      "omnisharp",    -- C#
      "pyright",      -- Python
      "tailwindcss",  -- Tailwind CSS
      "ts_ls",        -- TypeScript/JavaScript
    },
    -- Auto-setup each server with cmp capabilities
    handlers = {
      -- lua_ls: recognize Neovim globals (vim, etc.)
      lua_ls = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        lspconfig.lua_ls.setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = { library = vim.api.nvim_get_runtime_file("", true) },
              telemetry = { enable = false },
            },
          },
        })
      end,
      function(server_name)
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        lspconfig[server_name].setup({ capabilities = capabilities })
      end,
    },
  },
  config = function(_, opts)
    require("mason-lspconfig").setup(opts)
  end,
}
