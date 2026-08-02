return {
  "akinsho/git-conflict.nvim",
  event = "BufReadPost",
  opts = {
    default_mappings = true,
    default_commands = true,
    highlights = { incoming = "DiffAdd", current = "DiffText" },
  },
}
