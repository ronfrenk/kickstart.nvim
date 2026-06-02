# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). All configuration lives in `init.lua` with modular extensions under `lua/`.

## Formatting

Lua files must be formatted with **StyLua** before committing. Config is in `.stylua.toml`:
- 2-space indentation
- Single quotes preferred
- 160 column width
- No parentheses on bare function calls

```bash
stylua .          # format all Lua files
stylua --check .  # check without modifying (used in CI)
```

## Architecture

**Entry point:** `init.lua` — sets all vim options, keymaps, and bootstraps lazy.nvim, then requires everything under `lua/config/*.lua` automatically at the bottom.

**Plugin layers:**

| Path | Purpose |
|------|---------|
| `init.lua` (inline) | Core plugins: gitsigns, which-key, telescope, LSP stack, conform, blink.cmp, catppuccin, mini.nvim, treesitter |
| `lua/kickstart/plugins/` | Optional kickstart extras (debug, lint, autopairs, indent_line, neo-tree, gitsigns keymaps) — none are `require`d by default |
| `lua/custom/plugins/*.lua` | Personal plugins, auto-imported via `{ import = 'custom.plugins' }` |
| `lua/config/*.lua` | Personal autocommands and startup logic, auto-loaded after lazy setup |

**To add a new plugin:** create a file in `lua/custom/plugins/` returning a lazy.nvim plugin spec. It will be picked up automatically.

**To add startup logic:** add a `.lua` file to `lua/config/`. It will be `require`d automatically on every startup.

## LSP Setup

LSPs are managed by Mason + mason-lspconfig. Currently configured servers (in `init.lua`):
- `vtsls` — TypeScript/JavaScript with non-relative imports, inlay hints, and large project support
- `lua_ls` — Lua with lazydev integration for Neovim API completion

To add an LSP: add it to the `servers` table in `init.lua`. Mason will auto-install it.

## Key Bindings (leader = `<Space>`)

| Keys | Action |
|------|--------|
| `\` | Toggle Neo-tree file explorer |
| `<leader>sf` | Find files (Telescope) |
| `<leader>sg` | Live grep |
| `<leader>f` | Format buffer (conform) |
| `<leader>th` | Toggle inlay hints |
| `<leader>bat` | Show Batman ASCII art |
| `]c` / `[c` | Next/prev git hunk |
| `<leader>h*` | Git hunk actions (stage, reset, blame, diff) |

## Startup Behavior

`lua/config/rf_startup.lua` runs on `VimEnter` and:
1. Opens Neo-tree on the left (skipped for git commit/rebase buffers and when no file arg)
2. Shows a Batman welcome message
