-- keymaps.lua
-- Custom keybindings — keep them grouped by feature so they're easy to scan.

local map = vim.keymap.set

-- ── Filetypes that get HTML tag-expansion on Enter ─────────────────────────
local html_like_ft = { 'html', 'javascriptreact', 'typescriptreact', 'vue', 'svelte', 'xml', 'jsx', 'tsx' }

-- ── Move Lines (Alt+j / Alt+k) ─────────────────────────────────────────────

map('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down' })
map('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })
map('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- ── Indent / Outdent (Tab / Shift-Tab, VS Code style) ─────────────────────

map('v', '<Tab>', '>gv', { desc = 'Indent selection' })
map('v', '<S-Tab>', '<gv', { desc = 'Outdent selection' })
map('i', '<S-Tab>', '<C-d>', { desc = 'Outdent current line' })
map('n', '<Tab>', '>>_', { desc = 'Indent line' })
map('n', '<S-Tab>', '<<_', { desc = 'Outdent line' })

-- ── HTML Tag Expansion on Enter ────────────────────────────────────────────
-- Pressing Enter between <div>|</div> expands to:
--   <div>
--     |
--   </div>
--
-- We capture all state synchronously, then defer the actual buffer edit via
-- vim.schedule().  This avoids "not allowed to change text" errors that happen
-- when modifying the buffer directly inside an insert-mode keymap callback.

---Returns tag name if the text before the cursor ends with an opening tag.
local function opening_tag_name(text)
  return text:match '<(%w+)[^>]*>$'
end

---Returns tag name if the text after the cursor starts with a closing tag.
local function closing_tag_name(text)
  return text:match '^</(%w+)%s*>'
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = html_like_ft,
  callback = function(args)
    -- Remove o/O from indentkeys so normal-mode o/O use autoindent
    -- (copy previous line's indent) instead of treesitter's indentexpr,
    -- which often returns 0 for HTML and sends the cursor to column 0.
    local indentkeys = vim.bo[args.buf].indentkeys
    if indentkeys then
      vim.bo[args.buf].indentkeys = indentkeys:gsub('o,', ''):gsub(',O', ''):gsub('o', '')
    end

    map('i', '<CR>', function()
      local line = vim.api.nvim_get_current_line()
      local col = vim.api.nvim_win_get_cursor(0)[2] -- 0-indexed byte column

      local before = line:sub(1, col)
      local after = line:sub(col + 1)

      -- Capture everything we need before any deferred call
      local row = vim.api.nvim_win_get_cursor(0)[1]
      local base_indent = line:match '^(%s*)' or ''

      local tag = opening_tag_name(before)
      if not tag or closing_tag_name(after) ~= tag then
        -- Not between matching tags — insert newline at same indent scope
        local new_line_content = base_indent .. after
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(0, row - 1, row, false, { before, new_line_content })
          vim.api.nvim_win_set_cursor(0, { row + 1, #base_indent })
          vim.cmd 'startinsert'
        end)
        return
      end

      -- Between matching opening/closing tags — expand to three lines
      local sw = vim.bo.shiftwidth
      local child_indent = base_indent .. string.rep(' ', sw)
      local _, open_end = before:find '<%w+[^>]*>$'
      local open_part = line:sub(1, open_end)
      local close_part = after:match('^(</' .. tag .. '%s*>)')
      local trailing = after:sub(#close_part + 1)

      local new_lines = { open_part, child_indent, base_indent .. close_part }
      if trailing ~= '' then
        new_lines[3] = new_lines[3] .. trailing
      end

      vim.schedule(function()
        vim.api.nvim_buf_set_lines(0, row - 1, row, false, new_lines)
        vim.api.nvim_win_set_cursor(0, { row + 1, #child_indent })
        vim.cmd 'startinsert'
      end)
    end, { buffer = args.buf, desc = 'Expand HTML tag or newline' })
  end,
})
