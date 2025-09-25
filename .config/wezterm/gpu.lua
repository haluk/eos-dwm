local wezterm = require("wezterm")

local gpu = {}

function gpu.get_front_end()
  return wezterm.target_triple:match("darwin") and "WebGpu" or "OpenGL"
end

function gpu.get_webgpu_power_preference()
  return "HighPerformance"
end

function gpu.get_prefer_egl()
  return true
end

return gpu
