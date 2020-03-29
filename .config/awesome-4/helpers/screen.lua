local screen = {}

function screen.is_big(s)
  return s.geometry.width > 2500 and s.geometry.height > 1400
end

return screen
