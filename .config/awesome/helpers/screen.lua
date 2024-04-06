local screen = {}

function screen.is_big(s)
  return s.geometry.width > 2500 and s.geometry.height > 1400
end

function screen.is_floating_layout(s)
  local screen = s or awful.screen.focused()
  local layout = screen.selected_tag.layout.name
  return layout == "floating"
end

return screen
