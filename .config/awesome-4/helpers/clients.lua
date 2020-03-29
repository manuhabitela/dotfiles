local clients = {}

local function filter_visible_clients(current_screen, current_client)
  local visible_clients = current_screen.clients
  -- Remove all non-normal clients
  local fcls = {}
  for idx, c in ipairs(visible_clients) do
      if awful.client.focus.filter(c) or c == current_client then
          table.insert(fcls, c)
      end
  end
  return fcls
end

-- make focus_byidx work on all screens
-- kinda like focus_global_bydirection but here you can press only your usual two keys to go
-- forward and backward the clients list instead of having to really go with one of four directions
-- and it cycles (I use it as an alt-tab alternative)
function clients.client_focus_global_byidx(i, c)
  local multiple_screens = screen.count() > 1
  local current_client = c or client.focus
  local current_screen = current_client and current_client.screen or mouse.screen
  local visible_clients = filter_visible_clients(current_screen, current_client)
  local next_client = awful.client.next(i, current_client)

  if multiple_screens and current_client == visible_clients[1] and i == -1 then
    awful.screen.focus_relative(-1)
    local new_visible_clients = filter_visible_clients(client.focus.screen, client.focus)
    client.focus = new_visible_clients[#new_visible_clients]
  elseif multiple_screens and current_client == visible_clients[#visible_clients] and i == 1 then
    awful.screen.focus_relative(1)
    local new_visible_clients = filter_visible_clients(client.focus.screen, client.focus)
    client.focus = new_visible_clients[1]
  elseif next_client then
    client.focus = next_client
  end
end

function clients.update_client_colors(c)
  local bg_color, fg_color, border_color
  if c.maximized then
    bg_color = beautiful.bg_maximized
    -- fg_color = beautiful.fg_maximized
    border_color = beautiful.border_maximized
  elseif c.floating or awful.layout.get(client.screen) == awful.layout.suit.floating then
    bg_color = beautiful.bg_floating
    -- fg_color = beautiful.fg_floating
    border_color = beautiful.border_floating
  elseif client.focus == c then
    bg_color = beautiful.bg_focus
    -- fg_color = beautiful.fg_focus
    border_color = beautiful.border_focus
  else
    bg_color = beautiful.bg_normal
    fg_color = beautiful.fg_normal
    border_color = beautiful.border_normal
  end
  local osef, titlebar_size = c.titlebar_top(c)
  if titlebar_size ~= 0 then
    local client_titlebar = awful.titlebar(c, { size = beautiful.titlebar_size })
    client_titlebar:set_bg(bg_color)
    -- client_titlebar:set_fg(fg_color)
  end
  c.border_color = border_color
end

return clients