local M = {}

-- simple deepcopy fallback if vim.deepcopy is unavailable
local function deepcopy_tbl(t)
  if _G.vim and _G.vim.deepcopy then
    return _G.vim.deepcopy(t)
  end
  if type(t) ~= "table" then
    return t
  end
  local copy = {}
  for k, v in pairs(t) do
    if type(v) == "table" then
      copy[k] = deepcopy_tbl(v)
    else
      copy[k] = v
    end
  end
  return copy
end

-- Highest Contrast variant (purple-tinted, Obsidian-aligned)
M.dark = {
  -- Backgrounds
  bg0 = "#000000", -- editor background (pure black)
  bg1 = "#120f15", -- soft contrast background (Obsidian --dark-0)
  bg2 = "#17131b", -- hover/list backgrounds (Obsidian --dark-1)
  bg3 = "#1e1a23", -- subtle separators (Obsidian --dark-2)
  bg4 = "#25202c", -- elevated surfaces (Obsidian --dark-3)
  bg5 = "#2f2937", -- highest surface layer (Obsidian --dark-4)

  -- Foreground (warm cream, not pure white)
  fg0 = "#ece6de", -- editor foreground (Obsidian --text-primary)
  fg1 = "#c8bdb2", -- secondary text (Obsidian --text-secondary)
  fg2 = "#ab9f95", -- muted text (Obsidian --text-muted)
  fg3 = "#9e9184", -- faint text (Obsidian --text-faint)
  ui_fg = "#ece6de", -- general UI foreground (= fg0)

  -- Neutral borders
  border_neutral = "#2f2937", -- Obsidian --dark-4

  -- Core syntax (Obsidian-derived)
  comment = "#9f93ad", -- warm purple-gray (Obsidian --code-comment)
  string = "#b8bb26", -- olive (Obsidian --code-string)
  keyword = "#d798df", -- pink/magenta (Obsidian --code-keyword)
  func = "#8fd3ce", -- cyan/aqua (Obsidian --code-function)
  func_call = "#83a598", -- aqua for calls (Obsidian --support-aqua-500)
  number = "#fabd2f", -- golden (Obsidian --code-number)
  type = "#83a598", -- aqua/teal (Obsidian --code-type)
  operator = "#fe8019", -- deeper orange (Obsidian --code-operator)
  variable = "#d6cde4", -- light purple (Obsidian --code-normal)
  decorator = "#ae73b5", -- Obsidian --accent-300
  const = "#c69acc", -- light purple (Obsidian --code-property)
  preproc = "#fe8019", -- preprocessor/meta
  kw_ctrl = "#fb4934", -- control keywords (if/for/return, storage)
  property = "#c69acc", -- light purple (Obsidian --code-property)
  magic = "#8ec07c", -- Obsidian --support-green-500
  magic_method = "#8ec07c", -- legacy alias

  -- Language-specific colors
  latex_math = "#fabd2f", -- LaTeX math mode (golden)
  latex_comment = "#7a6e88", -- LaTeX comments (darker purple-gray)
  entity_name = "#b8bb26", -- Entity names (olive)

  -- Heading cascade (from Obsidian)
  heading_1 = "#b67abb", -- purple
  heading_2 = "#ecad4c", -- gold
  heading_3 = "#edb83a", -- golden-yellow
  heading_4 = "#8ec07c", -- green
  heading_5 = "#96c8c5", -- teal
  heading_6 = "#8db6e3", -- blue

  -- UI accents (purple family)
  cursor = "#ae73b5", -- Obsidian --accent-300
  selection = "#251630", -- purple accent at 28% on bg0
  selection_med = "#321d40", -- purple accent at 38%
  selection_high = "#3e244d", -- purple accent at 48% (matches Obsidian)
  linehl_subtle = "#110e16", -- purple-tinted subtle
  linehl = "#16121c", -- purple-tinted normal
  linehl_strong = "#1c1724", -- purple-tinted strong
  border_focus = "#c88bcf", -- Obsidian --focus-ring
  hover_bg = "#17131b", -- Obsidian --dark-1
  link = "#8cb6e8", -- Obsidian --link-color
  link_active = "#add2ff", -- Obsidian --link-hover
  line_nr_active = "#c88bcf", -- Obsidian --focus-ring (purple)
  line_nr = "#3a3244", -- Obsidian --dark-5

  -- VCS / Diff
  red = "#fb4934", -- Obsidian --support-red-500
  green = "#8ec07c", -- Obsidian --support-green-500
  warn = "#fabd2f", -- Obsidian --support-yellow-500
  info = "#7da8d8", -- Obsidian --support-blue-500
  hint = "#83a598", -- Obsidian --support-aqua-500
  ok = "#8ec07c", -- Obsidian --support-green-500
  diff_add_bg = "#121e17", -- green-tinted dark
  diff_delete_bg = "#1e1014", -- red-tinted dark
  diff_text = "#7da8d8", -- Obsidian --support-blue-500

  -- Utility
  gray = "#9f93ad", -- warm purple-gray (= comment)
  punct = "#9e9184", -- warm gray (= fg3)
  code_bg = "#1b1622", -- Obsidian --pre-code
  none = "NONE",

  -- Terminal ANSI
  term = {
    black = "#000000",
    red = "#fb4934",
    green = "#8ec07c",
    yellow = "#fabd2f",
    blue = "#7da8d8",
    magenta = "#d798df",
    cyan = "#8fd3ce",
    white = "#c8bdb2",

    bright_black = "#3a3244",
    bright_red = "#fc6a58",
    bright_green = "#a3d49a",
    bright_yellow = "#fccf5e",
    bright_blue = "#9dc0e8",
    bright_magenta = "#e4b0ea",
    bright_cyan = "#ade4df",
    bright_white = "#ece6de",
  },
}

-- Plum variant (VS Code "CoMPhy Gruvbox Plum"-aligned: near-black surfaces,
-- CoMPhy brand purple #68236D UI accent, Gruvbox/Dracula syntax hues)
M.plum = {
  -- Backgrounds
  bg0 = "#111111", -- editor background (near-black)
  bg1 = "#161616", -- soft contrast background (side surfaces)
  bg2 = "#1c1c1c", -- hover/list backgrounds
  bg3 = "#232323", -- subtle separators
  bg4 = "#2a2a2a", -- elevated surfaces
  bg5 = "#3c3836", -- highest surface layer (warm gruvbox gray)

  -- Foreground
  fg0 = "#fcfcfc", -- editor foreground (bright, near-white)
  fg1 = "#ebdbb2", -- secondary text (gruvbox cream)
  fg2 = "#a89984", -- muted text
  fg3 = "#7c6f64", -- faint text
  ui_fg = "#fcfcfc", -- general UI foreground (= fg0)

  -- Neutral borders
  border_neutral = "#3c3836",

  -- Core syntax
  comment = "#7887ab", -- cool blue-gray, italic
  string = "#50fa7b", -- bright dracula green
  keyword = "#f1fa8c", -- pale dracula yellow
  func = "#ff79c6", -- hot pink (definitions)
  func_call = "#b8bb26", -- olive for calls
  number = "#bd93f9", -- dracula lilac
  type = "#8be9fd", -- dracula cyan
  operator = "#ffb86c", -- soft orange
  variable = "#e2dcd0", -- warm off-white
  decorator = "#9b4fa0", -- purple (python decorators)
  const = "#d3869b", -- gruvbox pink
  preproc = "#fe8019", -- orange preprocessor/meta
  kw_ctrl = "#fb4934", -- control keywords (if/for/return, storage)
  property = "#83a598", -- gruvbox aqua-blue
  magic = "#8ec07c", -- gruvbox green (dunder/magic)
  magic_method = "#8ec07c", -- legacy alias

  -- Language-specific colors
  latex_math = "#fabd2f", -- LaTeX math mode (golden)
  latex_comment = "#928374", -- LaTeX comments (warm gray)
  entity_name = "#b8bb26", -- Entity names (olive)

  -- Heading cascade (markdown warm-to-cool)
  heading_1 = "#fb4934", -- red
  heading_2 = "#fe8019", -- orange
  heading_3 = "#fabd2f", -- yellow
  heading_4 = "#b8bb26", -- green
  heading_5 = "#83a598", -- blue
  heading_6 = "#d3869b", -- pink

  -- UI accents (CoMPhy brand purple family)
  cursor = "#9b4fa0", -- purple cursor
  selection = "#29162b", -- brand purple at ~28% on bg0
  selection_med = "#321834", -- brand purple at ~38%
  selection_high = "#3b1a3d", -- brand purple at ~48%
  linehl_subtle = "#1a1a1a", -- neutral subtle
  linehl = "#202020", -- neutral normal
  linehl_strong = "#262626", -- neutral strong
  border_focus = "#8a3b90", -- lighter brand purple
  hover_bg = "#1c1c1c",
  link = "#bd93f9", -- dracula lilac
  link_active = "#d6acff",
  line_nr_active = "#ffb86c", -- orange active line number
  line_nr = "#665c54",

  -- VCS / Diff
  red = "#fb4934",
  green = "#b8bb26",
  warn = "#d79921",
  info = "#83a598",
  hint = "#6272a4",
  ok = "#b8bb26",
  diff_add_bg = "#152112", -- green-tinted dark
  diff_delete_bg = "#241413", -- red-tinted dark
  diff_text = "#83a598",

  -- Utility
  gray = "#928374",
  punct = "#a89984",
  code_bg = "#1c1c1c",
  none = "NONE",

  -- Terminal ANSI
  term = {
    black = "#212121",
    red = "#ff5555",
    green = "#50fa7b",
    yellow = "#f1fa8c",
    blue = "#6cb6ff",
    magenta = "#bd93f9",
    cyan = "#8be9fd",
    white = "#cccccc",

    bright_black = "#6272a4",
    bright_red = "#ff6e6e",
    bright_green = "#69ff94",
    bright_yellow = "#ffffa5",
    bright_blue = "#79c7ff",
    bright_magenta = "#d6acff",
    bright_cyan = "#a4ffff",
    bright_white = "#ffffff",
  },
}

-- `M.light` intentionally starts as a deepcopy of `M.dark` for compatibility.
-- TODO: customize `M.light` to diverge from `M.dark` (true light backgrounds,
-- darker neutral text, and softer accent saturation).
-- Tracker: https://github.com/VatsalSy/comphy-theme.nvim/issues?q=is%3Aissue+is%3Aopen+light+palette
M.light = deepcopy_tbl(M.dark)

-- make palettes readonly (recursive) to avoid accidental mutation
local function readonly(tbl)
  local wrapped = {}
  for key, value in pairs(tbl) do
    if type(value) == "table" then
      wrapped[key] = readonly(value)
    else
      wrapped[key] = value
    end
  end

  return setmetatable({}, {
    __index = wrapped,
    __newindex = function()
      error("palette tables are readonly", 2)
    end,
    __pairs = function()
      return pairs(wrapped)
    end,
    __ipairs = function()
      return ipairs(wrapped)
    end,
  })
end

M.dark = readonly(M.dark)
M.light = readonly(M.light)
M.plum = readonly(M.plum)

return M
