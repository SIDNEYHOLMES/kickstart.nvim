-- This file is used to define native vim options
-- See :help option-list for every option ever

vim.opt.number = true -- line numbers
vim.opt.relativenumber = true -- relative line numbers
vim.opt.mouse = 'a' -- enable mouse
vim.opt.tabstop = 2 -- tab = 2 spaces
vim.opt.shiftwidth = 2 -- indent = 2 spaces
vim.opt.expandtab = true -- tabs → spaces
vim.opt.smartindent = true
vim.opt.wrap = false -- no line wrapping
vim.opt.swapfile = false -- no .swp files
vim.opt.undofile = true -- persistent undo
vim.opt.ignorecase = true -- case-insensitive search
vim.opt.smartcase = true -- ...unless you type uppercase
vim.opt.termguicolors = true -- true color support
vim.opt.signcolumn = 'yes' -- always show sign column
vim.opt.cursorline = true -- highlight current line
vim.opt.scrolloff = 8 -- keep 8 lines above/below cursor
vim.opt.updatetime = 50 -- faster CursorHold
vim.opt.splitbelow = true -- horizontal split below
vim.opt.splitright = true -- vertical split right
vim.opt.timeoutlen = 300 -- leader key timeout (ms)
vim.opt.shortmess:append 'I' -- disable nvim splash screen

-- Disable netrw (default file explorer) — Neotree handles this
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
