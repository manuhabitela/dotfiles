local clients = {}

local function filter_visible_clients(current_screen)
  local visible_clients = current_screen:get_clients(false)
  -- Remove all non-normal clients
  local fcls = {}
  for idx, c in ipairs(visible_clients) do
      if awful.client.focus.filter(c) then
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
  local visible_clients = filter_visible_clients(current_screen)
  local next_client = awful.client.next(i, current_client)
  if multiple_screens and current_client == visible_clients[1] and i == -1 then
    awful.screen.focus_relative(1)
    local new_visible_clients = filter_visible_clients(client.focus.screen)
    client.focus = new_visible_clients[#new_visible_clients]
  elseif multiple_screens and current_client == visible_clients[#visible_clients] and i == 1 then
    awful.screen.focus_relative(-1)
    local new_visible_clients = filter_visible_clients(client.focus.screen)
    client.focus = new_visible_clients[1]
  elseif next_client then
    client.focus = next_client
  end
end

function clients.count_instances(given_client, clients, compare)
  local clients = clients or client.get()
  local compare = compare or "class"
  local count = 0;
  for _, c in ipairs(clients) do
    if given_client[compare] == c[compare] then
      count = count + 1
    end
  end
  return count
end

function clients.move_out_to(c, t)
  c:move_to_tag(t)
  t:view_only()
end

function clients.show_titlebar_and_resize(c)
  awful.titlebar.show(c)
  c:relative_move(0, 0, 0, beautiful.statusbar_height * -1)
end

return clients