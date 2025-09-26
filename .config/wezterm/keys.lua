local wezterm = require("wezterm")
local keys = {}

function keys.get_leader()
  return { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }
end

function keys.get_keys()
  return {
    { mods = "LEADER", key = "c", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
    { mods = "LEADER", key = "x", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
    { mods = "LEADER", key = "v", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { mods = "LEADER", key = "s", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { mods = "LEADER", key = "h", action = wezterm.action.ActivatePaneDirection("Left") },
    { mods = "LEADER", key = "j", action = wezterm.action.ActivatePaneDirection("Down") },
    { mods = "LEADER", key = "k", action = wezterm.action.ActivatePaneDirection("Up") },
    { mods = "LEADER", key = "l", action = wezterm.action.ActivatePaneDirection("Right") },
    { mods = "LEADER", key = "[", action = wezterm.action.ActivateCopyMode },
    { mods = "LEADER", key = "z", action = wezterm.action.TogglePaneZoomState },
    { mods = "CTRL|SHIFT", key = "n", action = wezterm.action.EmitEvent("theme_next") },
    { mods = "CTRL|SHIFT", key = "p", action = wezterm.action.EmitEvent("theme_prev") },
  }
end

return keys
