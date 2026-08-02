return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    { "<leader>f", function() require("conform").format({ async = true }) end, desc = "Format buffer" },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      typescript = { "prettierd", "prettier" },
      typescriptreact = { "prettierd", "prettier" },
      javascript = { "prettierd", "prettier" },
      html = { "prettierd", "prettier" },
      css = { "prettierd", "prettier" },
      python = { "ruff_format" },
      csharp = { "csharpier" },
      bash = { "shfmt" },
      markdown = { "prettierd", "prettier" },
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
      return { timeout_ms = 2000, lsp_fallback = true }
    end,
  },
}
