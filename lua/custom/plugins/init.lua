-- Auto-load plugin configs from lua/custom/plugins/ and subdirectories.
-- Files are loaded in alphabetical order for reproducibility.
-- A broken file won't prevent the rest from loading (pcall-wrapped).

local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'plugins')

-- Collect entries first so we can sort them
local entries = {}
for name, type in vim.fs.dir(plugins_dir) do
  table.insert(entries, { name = name, type = type })
end
table.sort(entries, function(a, b) return a.name < b.name end)

for _, entry in ipairs(entries) do
  if entry.type == 'file' and entry.name:match '%.lua$' and entry.name ~= 'init.lua' then
    local ok, err = pcall(require, 'custom.plugins.' .. entry.name:gsub('%.lua$', ''))
    if not ok then vim.notify('custom/plugins: ' .. err, vim.log.levels.WARN) end
  elseif entry.type == 'directory' then
    local sub_entries = {}
    for fname, _ in vim.fs.dir(vim.fs.joinpath(plugins_dir, entry.name)) do
      if fname:match '%.lua$' then table.insert(sub_entries, fname) end
    end
    table.sort(sub_entries)
    for _, fname in ipairs(sub_entries) do
      local ok, err = pcall(require, 'custom.plugins.' .. entry.name .. '.' .. fname:gsub('%.lua$', ''))
      if not ok then vim.notify('custom/plugins/' .. entry.name .. ': ' .. err, vim.log.levels.WARN) end
    end
  end
end

