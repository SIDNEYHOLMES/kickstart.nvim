return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  opts = {
    ensure_installed = {
      "lua", "vim", "vimdoc",
      "typescript", "javascript", "tsx",
      "html", "css",
      "bash",
      "python",
      "c_sharp",
      "markdown", "markdown_inline",
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
    },
  },
}
