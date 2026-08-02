return {
  "echasnovski/mini.icons",
  lazy = true,
  init = function()
    -- Make sure mini.icons is available for plugins that prefer it
    package.preload["mini.icons"] = function()
      return require("mini.icons")
    end
  end,
  opts = {},
}
