--[[
KEYMAPS — single source of truth for all global keybindings.

Every mapping has a `desc` attribute so which-key.nvim can
auto-discover it. No need to register mappings in which-key.lua.

Architecture:
  - Global keybindings:   here in keymaps.lua
  - Plugin keybindings:   in each plugin file (telescope, conform, etc.)
  - LSP keybindings:      in lsp/lspconfig.lua (buffer-local via LspAttach)
  - which-key groups:     in which-key.lua (only group prefixes, auto-discovers rest)

Leader key = Space. Press Space then wait — which-key shows all available commands.
--]]

-- Leader key must be set before lazy.nvim loads
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ── Dashboard Mappings ───────────────────────────────────────────
-- F1 brings the dashboard(home page) to view
map('n', '<F1>', ':Alpha<CR>', opts)

-- ── Space as leader prefix ──────────────────────────────────────
-- Space alone does nothing — it only works as a prefix for leader combos
map('n', '<Space>', '<Nop>', opts)

-- ── Terminal ─────────────────────────────────────────────────────
-- Double Escape exits terminal mode back to normal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', opts)

-- ── Visual mode: move lines ─────────────────────────────────────
-- J/K in visual mode move selected lines up/down with auto-indent
map('v', 'J', ":m '>+1<CR>gv=gv", opts)
map('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- ── Navigation: keep cursor centered ───────────────────────────
-- Ctrl-d/u scroll half-page but keep cursor centered
-- n/N keep search results centered with some context
map('n', '<C-d>', '<C-d>zz', opts)
map('n', '<C-u>', '<C-u>zz', opts)
map('n', 'n', 'nzzzv', opts)
map('n', 'N', 'Nzzzv', opts)

-- ── Window navigation ───────────────────────────────────────────
-- Ctrl + hjkl moves between windows (like tmux)
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- ── Window splitting ────────────────────────────────────────────
-- <leader>%  vertical split   (like tmux %)
-- <leader>"  horizontal split (like tmux ")
-- <leader>&  close window
map('n', '<leader>%', ':vsplit<CR>', { desc = 'Vertical split' })
map('n', '<leader>"', ':split<CR>', { desc = 'Horizontal split' })
map('n', '<leader>&', ':close<CR>', { desc = 'Close window' })

-- ── Resize mode ─────────────────────────────────────────────────
-- <leader>r enters resize mode. Then:
--   Shift+h/j/k/l  resize by 5 in that direction
--   Any other key  exits resize mode
map('n', '<leader>r', function()
  print 'Resize: S-h/j/k/l, any other key exits'
  local resize = function(key, cmd) vim.keymap.set('n', key, cmd, { buffer = true, nowait = true }) end
  resize('<S-h>', '5<C-w><')
  resize('<S-j>', '5<C-w>-')
  resize('<S-k>', '5<C-w>+')
  resize('<S-l>', '5<C-w>>')
  for _, k in ipairs { 'h', 'j', 'k', 'l', '<Esc>', '<CR>', 'i', 'v' } do
    resize(k, function()
      for _, rk in ipairs { '<S-h>', '<S-j>', '<S-k>', '<S-l>', 'h', 'j', 'k', 'l', '<Esc>', '<CR>', 'i', 'v' } do
        pcall(vim.keymap.del, 'n', rk, { buffer = true })
      end
      print 'Resize off'
    end)
  end
end, { desc = 'Window resize mode (S-hjkl)' })

-- ── Buffer navigation ───────────────────────────────────────────
-- Uses real keybindings (not a modal system) so which-key shows them.
-- Buffer numbers match bufferline's ordinal display.
--
-- <leader>bn   Next buffer
-- <leader>bp   Previous buffer
-- <leader>bd   Delete buffer
-- <leader>bo   Close all other buffers
-- <leader>b1-9 Go to the 1st-9th listed buffer
--
-- NOTE: <leader>b1 goes to the FIRST listed buffer, NOT buffer number 1.
-- Uses getbufinfo() to get the i-th buffer from the listed list.
map('n', '<leader>bn', '<cmd>bnext<CR>', { desc = 'Next buffer' })
map('n', '<leader>bp', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
map('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Delete buffer' })
map('n', '<leader>bo', '<cmd>BufferLineCloseOthers<CR>', { desc = 'Close other buffers' })
for i = 1, 9 do
  map('n', '<leader>b' .. i, function()
    -- Get listed buffers in order (matches bufferline display order)
    local bufs = vim.fn.getbufinfo { buflisted = 1 }
    if bufs[i] then vim.api.nvim_set_current_buf(bufs[i].bufnr) end
  end, { desc = 'Go to buffer ' .. i })
end
