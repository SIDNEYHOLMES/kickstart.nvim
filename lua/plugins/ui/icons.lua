return {
  -- Primary icon provider
  {
    "echasnovski/mini.icons",
    opts = {},
  },
  -- Fallback icon provider (many plugins still depend on this)
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {},
  },
}
