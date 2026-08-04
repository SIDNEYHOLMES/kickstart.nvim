--[[
LSP server configs using vim.lsp.config (Neovim 0.11+ native)

Replaces nvim-lspconfig + mason-lspconfig. Each server gets:
  1. vim.lsp.config['name'] = { cmd, filetypes, root_markers, settings, ... }
  2. vim.lsp.enable('name')

Servers are installed by mason.nvim (mason.lua).
LSP keybindings are set up via LspAttach autocmd below.
--]]
return {
  'hrsh7th/cmp-nvim-lsp', -- provides default_capabilities()
  event = 'VeryLazy',
  config = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Helper: define + enable a server with capabilities merged in
    local function setup(name, config)
      config.capabilities = vim.tbl_deep_extend('keep', config.capabilities or {}, capabilities)
      vim.lsp.config[name] = config
      vim.lsp.enable(name)
    end

    -- ── bashls ───────────────────────────────────────────────────────
    setup('bashls', {
      cmd = { 'bash-language-server', 'start' },
      filetypes = { 'bash', 'sh' },
      root_markers = { '.git' },
    })

    -- ── cssls ────────────────────────────────────────────────────────
    setup('cssls', {
      cmd = { 'vscode-css-language-server', '--stdio' },
      filetypes = { 'css', 'scss', 'less' },
      root_markers = { 'package.json', '.git' },
    })

    -- ── html ─────────────────────────────────────────────────────────
    setup('html', {
      cmd = { 'vscode-html-language-server', '--stdio' },
      filetypes = { 'html' },
      root_markers = { 'package.json', '.git' },
    })

    -- ── lua_ls ───────────────────────────────────────────────────────
    setup('lua_ls', {
      cmd = { 'lua-language-server' },
      filetypes = { 'lua' },
      root_markers = {
        { '.luarc.json', '.luarc.jsonc', '.emmyrc.json' },
        { '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml' },
        '.git',
      },
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          diagnostics = { globals = { 'vim' } },
          workspace = { library = vim.api.nvim_get_runtime_file('', true) },
          telemetry = { enable = false },
        },
      },
    })

    -- ── omnisharp ────────────────────────────────────────────────────
    setup('omnisharp', {
      cmd = function(dispatchers, _)
        return vim.lsp.rpc.start({
          vim.fn.executable('OmniSharp') == 1 and 'OmniSharp' or 'omnisharp',
          '-z',
          '--hostPID',
          tostring(vim.fn.getpid()),
          'DotNet:enablePackageRestore=false',
          '--encoding',
          'utf-8',
          '--languageserver',
        }, dispatchers)
      end,
      filetypes = { 'cs', 'vb' },
      root_markers = { '*.sln', '*.csproj', 'omnisharp.json', '.git' },
    })

    -- ── pyright ──────────────────────────────────────────────────────
    setup('pyright', {
      cmd = { 'pyright-langserver', '--stdio' },
      filetypes = { 'python' },
      root_markers = {
        'pyrightconfig.json',
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
        '.git',
      },
    })

    -- ── tailwindcss ──────────────────────────────────────────────────
    setup('tailwindcss', {
      cmd = { 'tailwindcss-language-server', '--stdio' },
      filetypes = {
        'aspnetcorerazor', 'astro', 'astro-markdown', 'blade',
        'clojure', 'django-html', 'htmldjango', 'edge', 'eelixir',
        'elixir', 'ejs', 'erb', 'eruby', 'gohtml', 'gohtmltmpl',
        'haml', 'handlebars', 'hbs', 'html', 'htmlangular',
        'html-eex', 'heex', 'jade', 'leaf', 'liquid', 'markdown',
        'mdx', 'mustache', 'njk', 'nunjucks', 'php', 'razor',
        'slim', 'twig', 'css', 'less', 'postcss', 'sass', 'scss',
        'stylus', 'sugarss', 'javascript', 'javascriptreact',
        'reason', 'rescript', 'typescript', 'typescriptreact',
        'vue', 'svelte', 'templ',
      },
      root_markers = {
        'tailwind.config.js', 'tailwind.config.ts', 'tailwind.config.mjs',
        'tailwind.config.cjs', 'postcss.config.js', 'postcss.config.mjs',
        'package.json', '.git',
      },
    })

    -- ── ts_ls ───────────────────────────────────────────────────────
    setup('ts_ls', {
      cmd = { 'typescript-language-server', '--stdio' },
      filetypes = {
        'javascript', 'javascriptreact',
        'typescript', 'typescriptreact',
      },
      root_markers = {
        'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml',
        'bun.lockb', 'bun.lock', 'tsconfig.json', 'jsconfig.json',
        'package.json', '.git',
      },
    })

    -- ── LSP keybindings ─────────────────────────────────────────────
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspKeymaps', {}),
      callback = function(ev)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = ev.buf, desc = desc })
        end
        map('gd', vim.lsp.buf.definition, 'Go to definition')
        map('gr', vim.lsp.buf.references, 'References')
        map('K', vim.lsp.buf.hover, 'Hover')
        map('<leader>rn', vim.lsp.buf.rename, 'Rename')
        map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
        map('[d', function() vim.diagnostic.jump { count = -1, float = false } end, 'Previous diagnostic')
        map(']d', function() vim.diagnostic.jump { count = 1, float = false } end, 'Next diagnostic')
        map('<leader>q', vim.diagnostic.open_float, 'Show diagnostic error')
      end,
    })
  end,
}
