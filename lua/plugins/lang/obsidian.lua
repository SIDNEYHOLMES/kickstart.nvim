return {
  'epwalsh/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',
  cmd = {
    'ObsidianToday',
    'ObsidianSearch',
    'ObsidianQuickSwitch',
    'ObsidianBacklinks',
    'ObsidianFollowLink',
    'ObsidianToggleCheckbox',
    'ObsidianNewFromClipboard',
    'ObsidianOpenLinkInBrowser',
    'ObsidianPin',
    'ObsidianWorkspace',
    'ObsidianLink',
    'ObsidianLinkNew',
    'ObsidianRename',
    'ObsidianTemplate',
    'ObsidianExtractNote',
    'ObsidianPasteImg',
  },
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  opts = function()
    -- Ensure telescope loads before obsidian tries to use it as picker
    require 'telescope'
    local vault_base = '/mnt/c/Users/sidne/Desktop/Notes/Obsidian'
    local workspaces = {}
    local ok, entries = pcall(vim.fn.readdir, vault_base)
    if ok and #entries > 0 then
      for _, entry in ipairs(entries) do
        local full_path = vault_base .. '/' .. entry
        local stat = vim.loop.fs_stat(full_path)
        if stat and stat.type == 'directory' and entry:sub(1, 1) ~= '.' then table.insert(workspaces, { name = entry, path = full_path }) end
      end
    end
    if #workspaces == 0 then workspaces = { { name = 'Obsidian', path = vault_base } } end

    return {
      workspaces = workspaces,
      picker = { name = 'telescope.nvim' },
      daily_notes = {
        folder = 'daily',
        date_format = '%Y-%m-%d',
        alias_format = '%B %-d, %Y',
        default_tags = { 'daily-notes' },
      },
      note_id_func = function(title)
        local suffix = title and title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower() or tostring(os.time())
        return tostring(os.time()) .. '-' .. suffix
      end,
      note_frontmatter_func = function(note)
        local out = { id = note.id, aliases = note.aliases, tags = note.tags }
        if note.metadata and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,
      completion = { nvim_cmp = false, min_chars = 2 },
      ui = {
        enable = true,
        update_highlight = true,
        checkboxes = {
          [' '] = { char = ' ', hl_group = 'ObsidianTodo' },
          ['x'] = { char = 'x', hl_group = 'ObsidianDone' },
          ['>'] = { char = '>', hl_group = 'ObsidianRightArrow' },
          ['~'] = { char = '~', hl_group = 'ObsidianTilde' },
          ['!'] = { char = '!', hl_group = 'ObsidianImportant' },
          ['?'] = { char = '?', hl_group = 'ObsidianQuestion' },
          ['/'] = { char = '/', hl_group = 'ObsidianHalfDone' },
          ['-'] = { char = '-', hl_group = 'ObsidianCancelled' },
        },
      },
      follow_url_func = function(url) vim.fn.jobstart { 'explorer.exe', url } end,
      attachments = {
        img_folder = 'assets/imgs',
        img_name_func = function() return tostring(os.time()) .. '-' .. math.random(1000, 9999) end,
      },
      templates = { subdir = 'templates', date_format = '%Y-%m-%d', time_format = '%H:%M' },
      mappings = {
        ['gf'] = {
          action = function() vim.cmd.ObsidianFollowLink() end,
          opts = { buffer = true, noremap = false, expr = false, desc = 'Follow link under cursor' },
        },
        ['<leader>oc'] = { action = function() vim.cmd.ObsidianToggleCheckbox() end, opts = { buffer = true, desc = 'Toggle checkbox' } },
        ['<leader>on'] = { action = function() vim.cmd.ObsidianNewFromTemplate() end, opts = { buffer = true, desc = 'New note from template' } },
        ['<leader>os'] = { action = function() vim.cmd.ObsidianSearch() end, opts = { buffer = true, desc = 'Search vault' } },
        ['<leader>oo'] = { action = function() vim.cmd.ObsidianQuickSwitch() end, opts = { buffer = true, desc = 'Quick switch notes' } },
        ['<leader>od'] = { action = function() vim.cmd.ObsidianToday() end, opts = { buffer = true, desc = "Open today's daily note" } },
        ['<leader>ob'] = { action = function() vim.cmd.ObsidianBacklinks() end, opts = { buffer = true, desc = 'Show backlinks' } },
        ['<leader>ol'] = { action = function() vim.cmd.ObsidianOpen() end, opts = { buffer = true, desc = 'Open in Obsidian app' } },
        ['<leader>op'] = { action = function() vim.cmd.ObsidianPasteImg() end, opts = { buffer = true, desc = 'Paste image from clipboard' } },
      },
    }
  end,
}
