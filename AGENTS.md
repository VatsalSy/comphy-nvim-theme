# comphy-gruvbox.nvim

High-contrast Neovim colorscheme plugin with configurable contrast, italics/bold options, and language-specific highlight tuning.

## Structure

```text
comphy-nvim-theme/
├── colors/comphy_gruvbox.lua         # Colorscheme entrypoint for :colorscheme
├── lua/comphy_gruvbox/init.lua       # Public setup() API and option handling
├── lua/comphy_gruvbox/palette.lua    # Central color palette values
├── lua/comphy_gruvbox/groups.lua     # Highlight group definitions
├── examples/                         # Syntax fixtures for visual validation
└── README.md                         # User-facing setup and configuration docs
```

## Development

```bash
# Format Lua sources
stylua lua colors examples

# Quick load check (requires Neovim 0.10+)
nvim --headless -u NONE "+set rtp+=." "+lua require('comphy_gruvbox').setup()" "+colorscheme comphy_gruvbox" "+qa"
```

## Guidelines

- Keep palette definitions centralized in `lua/comphy_gruvbox/palette.lua`.
- Add or adjust highlight groups in `lua/comphy_gruvbox/groups.lua`; keep config handling in `lua/comphy_gruvbox/init.lua`.
- Preserve existing setup options and defaults unless intentionally changing public API behavior.
- Update `README.md` when adding new options, behaviors, or requirements.
