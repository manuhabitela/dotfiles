local wallpaper = {}

local last_update = nil

function wallpaper.update(s)
  local has_visible_clients = s.clients[1]
  local tag_has_visible_clients = false
  if has_visible_clients then
    local tag_clients = s.selected_tag:clients()
    if tag_clients then
      for idx, c in ipairs(tag_clients) do
        if c:isvisible() then
          tag_has_visible_clients = true
          break
        end
      end
    end
  end

  local wall = tag_has_visible_clients and beautiful.wallpaper_blur or beautiful.wallpaper
  if (last_update == wall) then
    return true
  end
  last_update = wall
  gears.wallpaper.maximized(wall, s, true)
end

return wallpaper
