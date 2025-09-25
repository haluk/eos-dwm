local wezterm = require("wezterm")
local qol = {}

function qol.apply(config)
  config.keys = config.keys or {}

  -- Copy/Paste
  table.insert(config.keys, { mods = "CTRL|SHIFT", key = "c", action = wezterm.action.CopyTo("Clipboard") })
  table.insert(config.keys, { mods = "CTRL|SHIFT", key = "v", action = wezterm.action.PasteFrom("Clipboard") })

  -- Search in scrollback
  table.insert(
    config.keys,
    { mods = "LEADER", key = "/", action = wezterm.action.Search({ CaseSensitiveString = "" }) }
  )

  -- Font size adjust
  table.insert(config.keys, { mods = "CTRL", key = "+", action = wezterm.action.IncreaseFontSize })
  table.insert(config.keys, { mods = "CTRL", key = "-", action = wezterm.action.DecreaseFontSize })
  table.insert(config.keys, { mods = "CTRL", key = "0", action = wezterm.action.ResetFontSize })

  -- Scrollback PgUp/PgDn
  table.insert(config.keys, { mods = "CTRL|SHIFT", key = "PageUp", action = wezterm.action.ScrollByPage(-1) })
  table.insert(config.keys, { mods = "CTRL|SHIFT", key = "PageDown", action = wezterm.action.ScrollByPage(1) })

  -- Direct tab switching: Leader + 0..9 → Tab 0..9
  for i = 0, 9 do
    table.insert(config.keys, {
      mods = "LEADER",
      key = tostring(i),
      action = wezterm.action.ActivateTab(i),
    })
  end

  config.enable_scroll_bar = false                     -- Ensure consistency with window.lua
  config.use_ime = true                                -- Enable input method editor for non-Latin input
  config.audible_bell = "Disabled"                     -- Disable annoying bell
  config.visual_bell = { fade_out_duration_ms = 75 }   -- Subtle visual bell

  -- Platform-specific: macOS blur
  if wezterm.target_triple:match("darwin") then
    config.macos_window_background_blur = 20
  end

  -- Default shell
  config.default_prog = { "/bin/zsh", "-l" }   -- Use zsh as default shell
end

return qol
