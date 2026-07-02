-- ── Webdev: 2-space indentation for JS/TS ────────────────────────────────────

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  callback = function()
    vim.opt_local.expandtab = true -- use spaces, not tabs
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.smartindent = true -- enable smart indentation
    vim.opt_local.autoindent = true  -- copy indent from current line when starting a new line
  end,
})
