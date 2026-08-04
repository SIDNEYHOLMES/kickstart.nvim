return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  build = ":MasonUpdate",
  opts = {
    ensure_installed = {
      'bashls',
      'cssls',
      'html',
      'lua_ls',
      'omnisharp',
      'pyright',
      'tailwindcss',
      'ts_ls',
    },
  },
}
