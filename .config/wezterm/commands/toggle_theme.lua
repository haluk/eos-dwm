local wezterm = require 'wezterm'
local colors = require("colors")  -- colors.lua in ~/.config/wezterm/

-- Collect all built-in color schemes
local schemes = wezterm.get_builtin_color_schemes()
local scheme_names = {}
for name, _ in pairs(schemes) do
  table.insert(scheme_names, name)
end
table.sort(scheme_names)

-- Determine starting scheme from colors.lua
-- You can optionally add `colors.current_scheme_name` in colors.lua for dynamic start
local starting_scheme = colors.current_scheme_name or scheme_names[0]

-- Find its index in the list
local scheme_index = 1
for i, name in ipairs(scheme_names) do
  if name == starting_scheme then
    scheme_index = i
    break
  end
end

local current_scheme = scheme_names[scheme_index]

-- Event: next theme
wezterm.on("theme_next", function(window)
  scheme_index = scheme_index + 1
  if scheme_index > #scheme_names then
    scheme_index = 1
  end
  current_scheme = scheme_names[scheme_index]
  window:set_config_overrides({ color_scheme = current_scheme })
  wezterm.log_info("Switched to " .. current_scheme)
end)

-- Event: previous theme
wezterm.on("theme_prev", function(window)
  scheme_index = scheme_index - 1
  if scheme_index < 1 then
    scheme_index = #scheme_names
  end
  current_scheme = scheme_names[scheme_index]
  window:set_config_overrides({ color_scheme = current_scheme })
  wezterm.log_info("Switched to " .. current_scheme)
end)

-- Commands for command palette
local theme_next = {
  brief = "Next theme",
  icon = "fa-palette",
  action = wezterm.action.EmitEvent("theme_next"),
}

local theme_prev = {
  brief = "Previous theme",
  icon = "fa-palette",
  action = wezterm.action.EmitEvent("theme_prev"),
}

-- Getter for current theme
local function get_current_theme()
  return current_scheme
end

-- Return commands and getter
return {
  theme_next = theme_next,
  theme_prev = theme_prev,
  get_current_theme = get_current_theme,
}
