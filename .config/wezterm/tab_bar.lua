local wezterm = require("wezterm")
local colors = require("colors")
local theme_command = require("commands.toggle_theme")
local tab_bar = {}

function tab_bar.apply(config)
  config.hide_tab_bar_if_only_one_tab = true
  config.tab_bar_at_bottom = true
  config.use_fancy_tab_bar = false

  wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local tab_num = tab.tab_index
    local host = tab.active_pane.title or "local"
    local display_text = string.format("%d: %s", tab_num, host)

    local active_bg = "#800080" -- purple for active tab
    local active_fg = "#FFFFFF" -- white for active tab
    local inactive_bg = colors.onedark.base00
    local inactive_fg = colors.onedark.base05
    local ssh_fg = "#61afef"               -- purple for SSH tabs
    local hover_bg = colors.onedark.base01 -- Slightly lighter background on hover

    -- Detect if the pane is an SSH session
    local fg_process = tab.active_pane.foreground_process_name or ""
    local is_ssh = fg_process:lower():match("ssh") ~= nil or host:lower():match("ssh") ~= nil or host:match("@") ~= nil

    -- Choose foreground color based on SSH status and activity
    local fg = tab.is_active and active_fg or (is_ssh and ssh_fg or inactive_fg)
    local bg = hover and hover_bg or (tab.is_active and active_bg or inactive_bg)

    return {
      { Background = { Color = bg } },
      { Foreground = { Color = fg } },
      { Text = " " .. display_text .. " " },
    }
  end)

  -- Right status bar: show current theme
  -- wezterm.on("update-right-status", function(window, _)
    -- window:set_right_status("Theme: " .. theme_command.get_current_theme())
  -- end)
end

return tab_bar
