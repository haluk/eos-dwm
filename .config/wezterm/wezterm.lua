local wezterm = require("wezterm")

-- Load modules
local font = require("font")
local colors = require("colors")
local keys = require("keys")
local tab_bar = require("tab_bar")
local window = require("window")
local gpu = require("gpu")
local qol = require("qol")
local commands = require("commands")

local config = wezterm.config_builder()
config.term = "xterm-256color"

-- Performance
config.max_fps = 120
config.animation_fps = 1
config.cursor_blink_rate = 0
config.scrollback_lines = 10000 -- Increased for more history

-- GPU
config.front_end = gpu.get_front_end()
config.webgpu_power_preference = gpu.get_webgpu_power_preference()
config.prefer_egl = gpu.get_prefer_egl()

-- Fonts
config.font = wezterm.font_with_fallback(font.get_all_fonts())
config.font_size = font.get_font_size()
config.harfbuzz_features = font.get_harfbuzz_features()

-- Colors
colors.apply(config)

-- Keys
config.leader = keys.get_leader()
config.keys = keys.get_keys()

-- Tab bar
tab_bar.apply(config)

-- Window
window.apply(config)

-- QoL / tmux-like
qol.apply(config)

-- Custom commands
wezterm.on("augment-command-palette", function()
  return commands
end)

return config
