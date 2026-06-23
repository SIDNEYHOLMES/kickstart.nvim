-- Snippets for web development
-- Loads friendly-snippets (VSCode-style snippets for React, JS, TS, CSS, HTML, etc.)
-- and adds custom snippets like rafce (React Arrow Function Component Export)

-- Load VSCode-style snippets
vim.pack.add { 'https://github.com/rafamadriz/friendly-snippets' }
require('luasnip.loaders.from_vscode').lazy_load()

-- Custom React snippets
local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- Converts the current filename to PascalCase for component names
-- e.g. "my-component.tsx" -> "MyComponent"
local function get_pascal_name()
  local name = vim.fn.expand('%:t:r') -- filename without extension
  if name == '' then return 'Component' end
  -- Handle kebab-case, snake_case, dot-case -> PascalCase
  name = name:gsub('[-_.]([a-zA-Z0-9])', function(c) return c:upper() end)
  name = name:gsub('^([a-z])', function(c) return c:upper() end)
  -- Remove any non-alphanumeric characters
  name = name:gsub('[^%w]', '')
  return name
end

-- rafce: React Arrow Function Component with Export (TypeScript)
ls.add_snippets('typescriptreact', {
  s('rafce', {
    t('const '),
    f(get_pascal_name),
    t(' = () => {'),
    t({ '', '\treturn (' }),
    t({ '', '\t\t<div>' }),
    i(1),
    t({ '', '\t\t</div>' }),
    t({ '', '\t);' }),
    t({ '', '};' }),
    t({ '', '' }),
    t('export default '),
    f(get_pascal_name),
    t(';'),
  }),
  s('rafc', {
    t('const '),
    f(get_pascal_name),
    t(' = () => {'),
    t({ '', '\treturn (' }),
    t({ '', '\t\t<div>' }),
    i(1),
    t({ '', '\t\t</div>' }),
    t({ '', '\t);' }),
    t({ '', '};' }),
  }),
})

-- Same snippets for JavaScript (JSX) files
ls.add_snippets('javascriptreact', {
  s('rafce', {
    t('const '),
    f(get_pascal_name),
    t(' = () => {'),
    t({ '', '\treturn (' }),
    t({ '', '\t\t<div>' }),
    i(1),
    t({ '', '\t\t</div>' }),
    t({ '', '\t);' }),
    t({ '', '};' }),
    t({ '', '' }),
    t('export default '),
    f(get_pascal_name),
    t(';'),
  }),
  s('rafc', {
    t('const '),
    f(get_pascal_name),
    t(' = () => {'),
    t({ '', '\treturn (' }),
    t({ '', '\t\t<div>' }),
    i(1),
    t({ '', '\t\t</div>' }),
    t({ '', '\t);' }),
    t({ '', '};' }),
  }),
})


