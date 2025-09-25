local font = {}

function font.get_font()
  return { "CaskaydiaCove NF" }
end

function font.get_fallback_fonts()
  return { "JetBrains Mono", "Fira Code" }
end

-- Returns a flat array of main + fallback fonts
function font.get_all_fonts()
  local fonts = {}
  for _, f in ipairs(font.get_font()) do table.insert(fonts, f) end
  for _, f in ipairs(font.get_fallback_fonts()) do table.insert(fonts, f) end
  return fonts
end

function font.get_font_size()
  return 12
end

function font.get_harfbuzz_features()
  return { "calt=1", "clig=1", "liga=1" }   -- enable ligatures
end

return font
