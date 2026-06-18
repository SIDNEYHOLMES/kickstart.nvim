-- keymaps.lua

-- ── Move Lines ────────────────────────────────────────────────────────────────

-- Normal mode: move current line down with Alt+j
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })

-- Normal mode: move current line up with Alt+k
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

-- Visual mode: move selected block down with Alt+j
-- gv=gv reselects and re-indents the block after moving
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

-- Visual mode: move selected block up with Alt+k
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
