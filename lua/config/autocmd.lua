--[[
AUTOCOMMANDS — automatic events that trigger on buffer/window actions.

Groups:
  General  - Cursor position restore on file open
--]]

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local general = augroup("General", { clear = true })

-- ── Restore cursor position ──────────────────────────────────────
-- When reopening a file, jump to where the cursor was last time
autocmd("BufReadPost", {
  group = general,
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, { mark[1], 0 })
    end
  end,
})
