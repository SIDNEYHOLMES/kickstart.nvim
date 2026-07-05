-- custom/lsp/init.lua
-- Dynamic LSP setup using mason-lspconfig handlers.
--
-- How it works:
--   1. Install any LSP via :Mason
--   2. The default handler auto-configures it — no file edits needed.
--   3. To override a server's defaults, create a file in this directory
--      named <server>.lua that returns a vim.lsp.Config table.
--      (See tailwindcss.lua and lua_ls.lua for examples.)
--
-- Servers listed in `ensure_installed` are kept installed automatically
-- by mason-tool-installer. Add new LSP names here to auto-install them.

-- ── Servers/tools Mason should keep installed ──────────────────────────
local ensure_installed = {
  'stylua',       -- Lua formatter (used by conform.nvim, not an LSP)
  'lua_ls',       -- Lua language server
  'tailwindcss',  -- Tailwind CSS class completions & linting
}

require('mason-tool-installer').setup { ensure_installed = ensure_installed }

-- ── Default handler — auto-configures any LSP without a custom file ────
-- This is what makes it dynamic: install via Mason → it just works.
local function default_handler(server_name)
  vim.lsp.config(server_name, {})
  vim.lsp.enable(server_name)
end

-- ── Build handlers table ───────────────────────────────────────────────
-- Start with the default handler (non-keyed function = fallback).
local handlers = { default_handler }

-- Scan this directory for per-server override files.
-- Each file should return a vim.lsp.Config table (see :help lsp-config).
local lsp_dir = vim.fn.stdpath('config') .. '/lua/custom/lsp/'
local scan_ok, fd = pcall(vim.uv.fs_scandir, lsp_dir)
if scan_ok and fd then
  while true do
    local name, t = vim.uv.fs_scandir_next(fd)
    if not name then break end
    if t == 'file' then
      local server_name = name:match('^(.*)%.lua$')
      if server_name and server_name ~= 'init' then
        local ok, config = pcall(require, 'custom.lsp.' .. server_name)
        if ok and type(config) == 'table' then
          -- Register this server with its custom config.
          handlers[server_name] = function()
            vim.lsp.config(server_name, config)
            vim.lsp.enable(server_name)
          end
        end
      end
    end
  end
end

-- ── Setup mason-lspconfig with the built handlers ──────────────────────
require('mason-lspconfig').setup {
  ensure_installed = ensure_installed,
  handlers = handlers,
}
