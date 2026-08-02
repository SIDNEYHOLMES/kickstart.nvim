return {
  "preservim/vim-markdown",
  ft = "markdown",
  init = function()
    vim.g.vim_markdown_folding_disabled = 1
    vim.g.vim_markdown_conceal = 0
    vim.g.vim_markdown_frontmatter = 1
    vim.g.vim_markdown_no_default_key_mappings = 1
  end,
}
