local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local myhelpers = require('helpers')
local mouse = require('mouse')
local leimi = {}
leimi.focused_clients = { {}, {}, {}, {} }
-- custom titlewidget:
-- * text aligned to left with small left-margin
-- * text becomes bold on focus
function leimi.titlewidget(c)
  local ret = wibox.widget.textbox()
  local function update_title()
    ret:set_text(c.name and ("  "..c.name) or "")
  end
  local function update_font()
    ret:set_font(c == client.focus and beautiful.font_title_focus or beautiful.font_title)
  end
  c:connect_signal("property::name", update_title)
  c:connect_signal("focus", update_font)
  c:connect_signal("unfocus", update_font)
  update_title()
  update_font()
  return ret
end

-- minimize button for the titlebar
function leimi.minimizebutton(c)
  local widget = awful.titlebar.widget.button(c, "minimize", function() return c.minimized end, function(c) c.minimized = not c.minimized end)
  c:connect_signal("property::minimized", widget.update)
  return widget
end

-- move to a tag through the given callback (awful.tag.viewnext, viewonly, etc)
-- keeps info about which client is focused on each tag before each move
-- in order to be able to put the focus back on them when going back on the tag
function leimi.gototag(callback)
  local current_screen = mouse.screen
  local from_tag = awful.tag.selected(current_screen)
  if client.focus then
    leimi.focused_clients[current_screen][from_tag] = client.focus
  end
  callback()
  local new_tag = awful.tag.selected(current_screen)
  if leimi.focused_clients[current_screen][new_tag] and awful.client.focus.filter(leimi.focused_clients[current_screen][new_tag]) then
    client.focus = leimi.focused_clients[current_screen][new_tag]
  else
    awful.client.focus.byidx( 1)
  end
  myhelpers.notify({ title = "Bureau "..new_tag.name, urgency = "low", time = 1000 })
end

function leimi.client_focus_global_byidx(i, c)
  local current_client = c or client.focus
  local current_screen = current_client and current_client.screen or mouse.screen
  local visible_clients = awful.client.visible(current_screen)
  -- Remove all non-normal clients
  local fcls = {}
  for idx, c in ipairs(visible_clients) do
      if awful.client.focus.filter(c) or c == current_client then
          table.insert(fcls, c)
      end
  end
  visible_clients = fcls

  local next_client = awful.client.next(i, current_client)

  if screen.count() > 1 and current_client == visible_clients[1] and i == -1 then
    awful.screen.focus_bydirection("left")
  elseif screen.count() > 1 and current_client == visible_clients[#visible_clients] and i == 1 then
    awful.screen.focus_bydirection("right")
  elseif next_client then
    client.focus = next_client
  end
end

return leimi