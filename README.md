# comphy-theme.nvim

A warm, purple-accent Neovim colorscheme aligned with the CoMPhy Obsidian theme. Features purple-tinted dark backgrounds, cream foreground, an Obsidian-derived syntax palette, and a six-color heading cascade. Extensive language-specific support for Python, LaTeX, Markdown, and more.

## Features

- **Warm Purple Backgrounds**: Purple-tinted near-black (`#0d0a11`) with cream (`#ece6de`) foreground
- **Soft Variant**: Enable soft contrast via `contrast = "soft"` to use the theme's `bg1` background for reduced eye strain
- **Obsidian Alignment**: Every color traces back to the CoMPhy Obsidian theme's design system
- **Heading Cascade**: Six distinct heading colors matching Obsidian (purple, gold, golden-yellow, green, teal, blue)
- **Language Support**:
  - Python: Decorators, self/cls, magic methods, type hints
  - LaTeX: Commands, environments, math mode, citations
  - Full Treesitter support with fallback to legacy syntax
- **Customizable**: Configure italics, bold, transparency per element

## Installation

### [lazy.nvim](https://github.com/folke/lazy.nvim) (recommended)

```lua
{
  "VatsalSy/comphy-theme.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("comphy-theme").setup({
      style = "dark",
      transparent = false,
      italics = {
        comments = true,
        strings = false,
        keywords = false,
        functions = false,
        variables = false,
      },
      bold = { functions = true },
    })
    vim.cmd.colorscheme("comphy-theme")
  end,
}
```

## Quick Setup

```lua
-- In your Neovim config (Lua)
require('comphy-theme').setup({ style = 'dark' })  -- 'light' currently mirrors 'dark'
vim.cmd.colorscheme('comphy-theme')
```

Note: The `style = 'light'` option currently aliases the dark palette. A true
light palette is planned; until then, `light` renders identically to `dark`.

```vim
" Vimscript equivalent
colorscheme comphy-theme
```

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "VatsalSy/comphy-theme.nvim",
  config = function()
    require("comphy-theme").setup()
    vim.cmd.colorscheme("comphy-theme")
  end
}
```

### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'VatsalSy/comphy-theme.nvim'
```

Then in your config:

```vim
colorscheme comphy-theme
```

## Color Palette

### Syntax Colors

| Element | Color | Hex | Source |
|---------|-------|-----|--------|
| Background | Purple-black | `#0d0a11` | Obsidian dark base |
| Foreground | Warm cream | `#ece6de` | `--text-primary` |
| Comments | Purple-gray | `#9f93ad` | `--code-comment` |
| Strings | Olive | `#b8bb26` | `--code-string` |
| Keywords | Pink/Magenta | `#d798df` | `--code-keyword` |
| Functions | Cyan/Aqua | `#8fd3ce` | `--code-function` |
| Numbers | Golden | `#fabd2f` | `--code-number` |
| Types | Aqua/Teal | `#83a598` | `--code-type` |
| Operators | Deep Orange | `#fe8019` | `--code-operator` |
| Variables | Light Purple | `#d6cde4` | `--code-normal` |

### Heading Cascade

| Level | Color | Hex |
|-------|-------|-----|
| H1 | Purple | `#b67abb` |
| H2 | Gold | `#ecad4c` |
| H3 | Golden-yellow | `#edb83a` |
| H4 | Green | `#8ec07c` |
| H5 | Teal | `#96c8c5` |
| H6 | Blue | `#8db6e3` |

### UI Accents

| Element | Color | Hex |
|---------|-------|-----|
| Cursor | Purple | `#ae73b5` |
| Selection | Deep purple | `#3e244d` |
| Focus ring | Pink-purple | `#c88bcf` |
| Links | Blue | `#8cb6e8` |
| Borders | Dark purple | `#2f2937` |

### Diagnostics

| Level | Color | Hex |
|-------|-------|-----|
| Error | Red | `#fb4934` |
| Warning | Yellow | `#fabd2f` |
| Info | Blue | `#7da8d8` |
| Hint | Aqua | `#83a598` |
| OK | Green | `#8ec07c` |

## Configuration

```lua
require("comphy-theme").setup({
  style = "dark",       -- "dark" (default). "light" currently mirrors "dark"; invalid falls back to "dark"
  transparent = false,  -- Transparent background
  terminal_colors = true, -- Set terminal colors
  contrast = "highest",  -- "highest" | "soft"
  -- Visual intensity controls
  selection_intensity = "high",   -- "low" | "medium" | "high"
  cursorline_intensity = "subtle", -- "subtle" | "normal" | "strong"
  italics = {
    comments = true,
    strings = false,
    keywords = false,
    functions = false,
    variables = false,
  },
  bold = {
    functions = true,
  },
  overrides = {}, -- Override specific highlight groups
})
```

### Override Examples

```lua
require("comphy-theme").setup({
  overrides = {
    -- Make comments bold and italic
    Comment = { fg = "#9f93ad", bold = true, italic = true },
    -- Change function color
    Function = { fg = "#b8bb26" },
  }
})
```

## Python Support

The theme includes comprehensive Python highlighting:

- **Decorators** (`@property`, `@staticmethod`): Purple `#ae73b5`
- **Self/cls**: Light purple italic `#c69acc`
- **Built-in functions** (`print`, `len`): Orange `#fe8019`
- **Magic methods** (`__init__`, `__str__`): Green `#8ec07c`
- **Docstrings**: Comment style with italics
- **Type hints**: Aqua `#83a598`
- **Keywords** (`class`, `def`, `async`): Red `#fb4934`

## LaTeX Support

Extensive LaTeX highlighting with proper coloring:

- **Commands** (`\documentclass`, `\usepackage`): Aqua `#83a598`
- **Control keywords** (`\begin`, `\end`): Red `#fb4934`
- **Math mode**: Golden `#fabd2f`
- **Environment names**: Aqua `#83a598`
- **Comments** (starting with `%`): Purple-gray italic `#7a6e88`

## Language Examples

See the `examples/` directory for syntax highlighting demonstrations in:
- Python (`demo.py`)
- LaTeX (`demo.tex`)
- JavaScript/TypeScript (`demo.js`, `demo.ts`)
- Rust (`demo.rs`)
- Go (`demo.go`)
- And more...

## Requirements

- Neovim 0.10.0 or higher
- `termguicolors` enabled
- Optional: Treesitter for enhanced syntax highlighting

Note: This theme defines the `LspInlayHint` highlight group, which was
introduced in Neovim 0.10.0. If you are on 0.9.x or older, please upgrade to
0.10.0+ or remove any inlay-hint-related configuration from your setup to avoid
warnings.

## License

MIT © 2025 Vatsal Sanjay

## Acknowledgments

- Palette derived from the [CoMPhy Obsidian theme](https://github.com/VatsalSy/comphy-obsidian-theme)
- Original gruvbox theme by [morhetz](https://github.com/morhetz/gruvbox)
