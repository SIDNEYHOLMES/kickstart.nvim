# SIDNEY NVIM V2

Personal Neovim config — modular rewrite of [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). Focused on React/TypeScript webdev with continued updates for whatever I need.

**V2 is a full restructure.** The original kickstart single-file `init.lua` is split into `lua/config/` (options, keymaps, autocmds) and `lua/plugins/` (organized by category). If you are coming from the `main` branch, back up your old config first — V2 is not a drop-in upgrade.

## Requirements

- **Neovim >= 0.10** (stable or nightly)
- **git**, **make**, **gcc** (or another C compiler), **unzip**
- **[ripgrep](https://github.com/BurntSushi/ripgrep)** — Telescope live grep
- **[fd](https://github.com/sharkdp/fd)** — Telescope file search
- **[tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md)** — syntax parser compilation
- **A [Nerd Font](https://www.nerdfonts.com/)** — icons in file tree, statusline, dashboard
- **xclip** or **wl-clipboard** (Linux) — system clipboard
- **Node.js / npm** — TypeScript/JS LSP and formatters

## Fresh Install

### 1. Back up and wipe old config

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
```

### 2. Install system dependencies

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install make gcc ripgrep fd-find tree-sitter-cli unzip git xclip curl

# Neovim stable via PPA
sudo add-apt-repository ppa:neovim-ppa/stable -y
sudo apt update
sudo apt install neovim
```

**Arch:**
```bash
sudo pacman -S --needed gcc make git ripgrep fd tree-sitter-cli unzip neovim
```

**Fedora:**
```bash
sudo dnf install -y gcc make git ripgrep fd-find tree-sitter-cli unzip neovim
```

**WSL (Ubuntu):**
```bash
sudo add-apt-repository ppa:neovim-ppa/stable -y
sudo apt update
sudo apt install make gcc ripgrep fd-find tree-sitter-cli unzip git xclip neovim
```

### 3. Install a Nerd Font

Download from [nerdfonts.com](https://www.nerdfonts.com/). JetBrainsMono Nerd Font recommended. Install to `~/.local/share/fonts/` and run `fc-cache -fv`. Set your terminal to use it.

### 4. Clone this repo

```bash
git clone https://github.com/SIDNEYHOLMES/kickstart.nvim.git ~/.config/nvim
cd ~/.config/nvim
git checkout V2
```

### 5. Launch Neovim

```bash
nvim
```

Lazy.nvim bootstraps itself on first run, then installs all plugins. Let it finish — this takes a minute or two on first launch. Treesitter parsers and Mason LSP servers install automatically after plugins load.

### 6. Verify

- `:Lazy` — all plugins installed, no errors
- `:Mason` — LSP servers installed (bashls, cssls, html, lua_ls, omnisharp, pyright, tailwindcss, ts_ls)
- `:checkhealth` — no critical failures
- Open a `.tsx` file — treesitter highlights, LSP autocompletion works

## Structure

```
~/.config/nvim/
├── init.lua                  # Entry point — loads config/ then lazy
├── lazy-lock.json            # Pinned plugin versions (track in git)
├── lua/
│   ├── config/
│   │   ├── options.lua       # vim.opt settings
│   │   ├── keymaps.lua       # All global keybindings (leader = Space)
│   │   ├── autocmd.lua       # Autocommands
│   │   └── Lazy.lua          # Plugin manager bootstrap
│   └── plugins/
│       ├── init.lua           # Imports all plugin categories
│       ├── ui/                # colorscheme, statusline, bufferline, dashboard, which-key
│       ├── editor/            # treesitter, telescope, neo-tree, commenting, surround, formatting, multicursor
│       ├── lsp/               # mason, lspconfig (vim.lsp.config), cmp
│       ├── lang/              # markdown, obsidian
│       └── git/               # gitsigns, diffview, neogit
└── after/
    └── ftplugin/              # Filetype-specific overrides
```

## Keybindings

Leader key is **Space**. Press Space and wait — which-key shows all available commands.

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files (Telescope) |
| `<leader>fg` | Live grep (Telescope) |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Help tags |
| `<leader>e` | Toggle Neo-tree file explorer |
| `<leader>bn` | Next buffer |
| `<leader>bp` | Previous buffer |
| `<leader>b1-9` | Go to buffer 1-9 |
| `<leader>bd` | Delete buffer |
| `<leader>bo` | Close other buffers |
| `<leader>%` | Vertical split |
| `<leader>"` | Horizontal split |
| `<leader>&` | Close window |
| `<leader>r` | Resize mode (Shift+hjkl) |
| `<C-h/j/k/l>` | Move between windows |
| `<C-d/u>` | Half-page scroll (centered) |
| `J/K` (visual) | Move selected lines up/down |
| `gx` | Open URL under cursor |
| `<F1>` | Dashboard (Alpha) |

## Plugins

### UI
- **tokyonight.nvim** — Colorscheme (storm variant, transparent)
- **lualine.nvim** — Statusline
- **bufferline.nvim** — Tab-like buffer tabs
- **alpha-nvim** — Start dashboard
- **which-key.nvim** — Keybinding popup
- **nvim-web-devicons** — File icons

### Editor
- **nvim-treesitter** — Syntax highlighting, text objects
- **telescope.nvim** — Fuzzy finder
- **neo-tree.nvim** — File explorer
- **Comment.nvim** — `gcc` / `gc` to toggle comments
- **nvim-surround** — `ys` / `ds` / `cs` for surrounding pairs
- **conform.nvim** — Format on save
- **nvim-autotag** — Auto-close/rename HTML/JSX tags
- **multicursors.nvim** — Multiple cursors (`<C-n>`)

### LSP
- **mason.nvim** — LSP server installer
- **vim.lsp.config** (builtin) — LSP configuration (no nvim-lspconfig)
- **nvim-cmp** — Autocompletion (LuaSnip, friendly-snippets, path, buffer sources)
- **none-ls.nvim** — Diagnostics (eslint, stylelint)

### Git
- **gitsigns.nvim** — Gutter signs
- **diffview.nvim** — Diff viewer
- **neogit** — Git UI (magit-style)

### Language
- **markdown-preview.nvim** — Preview markdown in browser
- **obsidian.nvim** — Obsidian vault integration

## Updating

```bash
cd ~/.config/nvim
git pull
nvim +Lazy sync
```

## Uninstall

```bash
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```
