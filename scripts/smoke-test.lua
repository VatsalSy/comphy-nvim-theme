-- Headless load check for every style the plugin advertises.
--
-- Run with:  nvim --headless --clean -u NONE -c "set rtp+=$PWD" \
--                 -c "luafile scripts/smoke-test.lua" -c q
--
-- Asserts that each style loads without error, paints the background it claims
-- to paint, and reports a `&background` value consistent with that paint.

local failures = {}

local function check(name, cond, detail)
  if not cond then
    table.insert(failures, string.format("%s: %s", name, detail or "assertion failed"))
  end
end

local function normal_bg()
  return vim.api.nvim_get_hl(0, { name = "Normal" }).bg
end

local expected = {
  dark = 0x000000,
  plum = 0x111111,
  -- `light` is a documented stub that reuses the dark palette.
  light = 0x000000,
}

for _, style in ipairs({ "dark", "plum", "light" }) do
  local ok, err = pcall(function()
    require("comphy-theme").setup({ style = style })
    require("comphy-theme").load()
  end)
  check(style, ok, "failed to load: " .. tostring(err))

  if ok then
    check(
      style,
      normal_bg() == expected[style],
      string.format(
        "Normal.bg is %s, expected %s",
        string.format("#%06x", normal_bg() or 0),
        string.format("#%06x", expected[style])
      )
    )

    -- Guards the class of bug where a style paints dark surfaces while telling
    -- plugins that branch on `&background` to assume a light editor.
    local claims_light = vim.o.background == "light"
    local paints_light = (normal_bg() or 0) > 0x808080
    check(
      style,
      claims_light == paints_light,
      string.format(
        "&background=%s but Normal.bg=%s",
        vim.o.background,
        string.format("#%06x", normal_bg() or 0)
      )
    )
  end

  check(
    style,
    vim.g.colors_name == "comphy-theme",
    "colors_name is " .. tostring(vim.g.colors_name)
  )
end

-- `:colorscheme comphy-theme` must work without a prior setup() call.
local ok_cs, err_cs = pcall(vim.cmd.colorscheme, "comphy-theme")
check("colorscheme", ok_cs, tostring(err_cs))

if #failures > 0 then
  io.stderr:write("smoke test FAILED\n")
  for _, f in ipairs(failures) do
    io.stderr:write("  - " .. f .. "\n")
  end
  vim.cmd("cquit 1")
end

print("smoke test passed: dark, plum, light")
