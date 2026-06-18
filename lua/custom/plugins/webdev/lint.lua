-- Linters for web development
-- Configures nvim-lint to use ESLint for JavaScript and TypeScript

local lint = require('lint')
lint.linters_by_ft = vim.tbl_deep_extend('force', lint.linters_by_ft or {}, {
  javascript = { 'eslint' },
  typescript = { 'eslint' },
  javascriptreact = { 'eslint' },
  typescriptreact = { 'eslint' },
})