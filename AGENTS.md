# comphy-theme.nvim

Warm, purple-accent Neovim colorscheme aligned with the CoMPhy Obsidian theme. Features purple-tinted backgrounds, cream foreground, Obsidian-derived syntax colors, a six-color heading cascade, and language-specific highlight tuning.

## Structure

```text
comphy-nvim-theme/
├── colors/comphy-theme.lua          # Colorscheme entrypoint for :colorscheme
├── lua/comphy-theme/init.lua        # Public setup() API and option handling
├── lua/comphy-theme/palette.lua     # Central color palette values
├── lua/comphy-theme/groups.lua      # Highlight group definitions
├── examples/                        # Syntax fixtures for visual validation
└── README.md                        # User-facing setup and configuration docs
```

## Development

```bash
# Format Lua sources
stylua lua colors examples

# Quick load check (requires Neovim 0.10+)
nvim --headless -u NONE "+set rtp+=." "+lua require('comphy-theme').setup()" "+colorscheme comphy-theme" "+qa"
```

## Guidelines

- Keep palette definitions centralized in `lua/comphy-theme/palette.lua`.
- Add or adjust highlight groups in `lua/comphy-theme/groups.lua`; keep config handling in `lua/comphy-theme/init.lua`.
- Preserve existing setup options and defaults unless intentionally changing public API behavior.
- Update `README.md` when adding new options, behaviors, or requirements.
