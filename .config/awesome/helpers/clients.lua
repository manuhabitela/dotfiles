local clients = {}
local textbox = require("wibox.widget.textbox")

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

-- made with ai
local function filter_ignored_clients(clients_list)
  -- Filter out clients whose class or instance matches alt_tab_ignored_instances
  local filtered = {}
  for _, c in ipairs(clients_list) do
    local should_ignore = false
    for _, ignored in ipairs(alt_tab_ignored_instances or {}) do
      if c.class == ignored or c.instance == ignored then
        should_ignore = true
        break
      end
    end
    for _, ignored in ipairs(alt_tab_ignored_names or {}) do
      if c.name == ignored then
        should_ignore = true
        break
      end
    end
    if not should_ignore then
      table.insert(filtered, c)
    end
  end
  return filtered
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

-- Focus next/prev client while ignoring windows in alt_tab_ignored_instances
-- the idea is that it's the same as awful.client.focus.byidx but it ignores some clients
-- made with ai
function clients.focus_filtered_byidx(i, c)
  local current_client = c or client.focus
  local current_screen = current_client and current_client.screen or mouse.screen
  local visible_clients = filter_ignored_clients(filter_visible_clients(current_screen))

  -- Find current client index in filtered list
  local current_idx = 0
  for idx, client in ipairs(visible_clients) do
    if client == current_client then
      current_idx = idx
      break
    end
  end

  if #visible_clients > 0 then
    -- Calculate next index with wraparound
    local next_idx
    if i == 1 then
      next_idx = current_idx == #visible_clients and 1 or current_idx + 1
    else
      next_idx = current_idx == 1 and #visible_clients or current_idx - 1
    end

    client.focus = visible_clients[next_idx]
    if client.focus then
      client.focus:raise()
    end
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

function clients.titlebar_widget(c)
  local ret = textbox()
  local function update()
    local text = ""
    if c.maximized then
      text = text .. "+"
    else
      if c.floating then text = text .. "~" end
    end
    if c.ontop then text = text .. "^" end
    if c.sticky then text = text .. "*" end
    text = text ~= "" and (text .. " | ") or text
    text = text .. (c.name or titlebar.fallback_name)
    ret:set_text(text)
  end
  c:connect_signal("property::name", update)
  c:connect_signal("property::sticky", update)
  c:connect_signal("property::ontop", update)
  c:connect_signal("property::floating", update)
  c:connect_signal("property::maximized", update)

  update()

  return ret
end

return clients
