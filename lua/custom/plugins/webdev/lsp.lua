-- LSP servers for web development
-- Configures language servers for JS/TS, CSS, HTML, JSON, ESLint, Tailwind, Emmet.
-- The LSP infrastructure (mason, lspconfig, LspAttach handler) is in plugins/lsp.lua.

local servers = {
  ts_ls = {},
  cssls = {},
  jsonls = {},
  html = {},
  eslint = {},
  tailwindcss = {},
  emmet_language_server = {
    filetypes = { 'html', 'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  },
}

-- Show line diagnostics automatically in hover window
vim.diagnostic.config {
  virtual_text = false,
}

vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end
