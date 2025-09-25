local colors = require("colors")

local window = {}

function window.apply(config)
  config.initial_cols = 120   -- Consistent window size
  config.initial_rows = 30
  config.window_background_opacity = 0.95
  config.enable_scroll_bar = false
  config.window_decorations = "RESIZE"

  config.window_frame = {
    active_titlebar_bg = colors.onedark.base00,   -- Match theme
    inactive_titlebar_bg = colors.onedark.base01,
  }

  config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  }
end

return window
