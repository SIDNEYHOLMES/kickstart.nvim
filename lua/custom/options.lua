-- options.lua
-- Editor options that apply globally or per-filetype.

-- ── Indent behaviour ───────────────────────────────────────────────────────

vim.o.autoindent = true -- new lines copy the indent of the previous line
vim.o.copyindent = true -- preserve indent structure when copying
vim.o.preserveindent = true -- preserve indent when pasting

-- ── Webdev: 2-space indentation ────────────────────────────────────────────

local web_filetypes = {
  'javascript',
  'javascriptreact',
  'typescript',
  'typescriptreact',
  'html',
  'css',
  'scss',
  'json',
  'jsonc',
  'yaml',
  'xml',
  'markdown',
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = web_filetypes,
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
})
