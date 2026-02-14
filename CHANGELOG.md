# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-01-06

### Changed

- Rebranded from `gruvbox_custom_crisp_themes.nvim` to `comphy-gruvbox.nvim`
- Module name changed from `gruvbox_crisp` to `comphy_gruvbox`
- Colorscheme name changed from `gruvbox_crisp` to `comphy_gruvbox`

### Features

- Initial release with VSCode Gruvbox Crisp (Highest Contrast, pop) specification
- Pure black (#000000) background for maximum contrast
- Vibrant Dracula-inspired color palette
- Comprehensive Python syntax support:
  - Decorators: purple (#9b4fa0)
  - self/cls parameters: italic, parameter color (#83a598)
  - Magic/dunder methods: dedicated color (#8ec07c)
  - Type hints and annotations: cyan (#8be9fd)
  - Docstrings: comment color, italic (#6272a4)
- Full LaTeX highlighting support:
  - LaTeX commands: green (#b8bb26)
  - Control keywords (\begin, \end): red (#fb4934)
  - Math mode: yellow (#fabd2f)
  - Environment names: cyan (#8be9fd)
  - Comments (%): gray, italic (#7c6f64)
- Tree-sitter support with fallback to legacy Vim syntax
- Customizable italics and bold options
- Terminal color configuration
- Override capability for highlight groups
- Soft contrast option adjusts the base editor background to a slightly softer, dark gray shade

### Docs

- Clarify that `style = 'light'` currently aliases the dark palette. A true
  light palette is planned; until then `light` renders identical to `dark`.
- Update Requirements to "Neovim 0.10.0 or higher" and note that the
  `LspInlayHint` highlight group was introduced in Neovim 0.10.0; users on
  older versions should upgrade or remove inlay-hint-related configuration.

[1.0.0]: https://github.com/VatsalSy/comphy-gruvbox.nvim/releases/tag/v1.0.0
