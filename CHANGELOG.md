# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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
