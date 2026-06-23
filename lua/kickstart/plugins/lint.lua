-- Linting

vim.pack.add { 'https://github.com/mfussenegger/nvim-lint' }

-- To allow other plugins to add linters (e.g. custom/plugins/webdev/lint.lua),
-- the linters_by_ft table is set in-place rather than overwritten.
local lint = require 'lint'
lint.linters_by_ft = {}
-- Only enable markdownlint if the CLI is installed
if vim.fn.executable 'markdownlint' == 1 then
  lint.linters_by_ft.markdown = { 'markdownlint' }
end

-- Create autocommand which carries out the actual linting
-- on the specified events.
local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    -- Only run the linter in buffers that you can modify in order to
    -- avoid superfluous noise, notably within the handy LSP pop-ups that
    -- describe the hovered symbol using Markdown.
    if vim.bo.modifiable then lint.try_lint() end
  end,
})
