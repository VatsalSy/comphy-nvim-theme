# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed

- Install instructions pointed at `VatsalSy/comphy-theme.nvim`, which does not
  exist and does not redirect. The repository is `comphy-lab/comphy-nvim-theme`;
  every lazy.nvim, packer and vim-plug snippet in the README was unusable.
- `style = "light"` set `vim.o.background = "light"` while loading the dark
  palette, so plugins that branch on `&background` applied light-mode heuristics
  to a near-black editor. The flag now reports `dark` until `palette.light`
  actually diverges from `palette.dark`.

### Added

- `scripts/smoke-test.lua`, which loads every advertised style headlessly,
  asserts the painted background, and fails when `&background` disagrees with
  what the palette paints.
- `groups.lua` reformatted to satisfy the `.stylua.toml` already in the
  repository.
- CI, which this repository previously had none of: the smoke test runs on
  Neovim 0.9.5 and stable, and stylua is enforced.

## [v1.1.0] - 2026-08-09

### Added

- **`style = "plum"` palette** ("CoMPhy Gruvbox Plum"): near-black `#111111` editor on `#161616` surfaces, bright `#fcfcfc` foreground, CoMPhy brand purple `#68236D` selection/UI accent, and Gruvbox/Dracula syntax hues — pale yellow keywords, bright green strings, hot-pink functions, cyan types, orange operators, cool blue-gray comments. Matches the VS Code theme of the same name.

## [v1.0.0] - 2026-02-15

### Added

- Complete palette overhaul aligned with CoMPhy Obsidian theme
- Purple-tinted background layers (bg0–bg5) with pure black editor background
- Warm cream foreground tiers (fg0–fg3) from Obsidian text hierarchy
- Obsidian-derived syntax colors: olive strings, pink keywords, cyan functions, golden numbers, aqua types, orange operators, light purple variables
- Six-color heading cascade matching Obsidian (purple, gold, golden-yellow, green, teal, blue)
- Purple-family UI accents (cursor, selection, focus ring, line numbers)
- Full terminal ANSI palette (16 colors)
- `code_bg` key for code block backgrounds
- `func_call` palette key (replaces former `func_green`)
- `bg4`, `bg5`, `fg2`, `fg3` palette keys for finer layering

### Changed

- Renamed module from `comphy_gruvbox` to `comphy-theme`
- Colorscheme command: `:colorscheme comphy-theme`
- Require path: `require("comphy-theme")`
- All syntax colors replaced — zero Dracula orphans remain
- Diagnostics use warmer Obsidian support palette (red, yellow, blue, aqua, green)
- Search highlights: dark-on-golden (was dark-on-keyword)
- MatchParen: fg0 on selection with bold (was plain bg2)
- PmenuSel: uses selection_high (was hover_bg)
- `@namespace`: keyword color (was number)
- `@markup.raw`: uses variable/code-normal (was string)
- `@markup.strong`: light purple bold; `@markup.italic`: green italic
- Legacy Markdown headings use per-level colors instead of link to Title

### Removed

- All Dracula-inspired colors
- `func_green` palette key (replaced by `func_call`)
