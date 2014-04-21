local awful = require('awful')
local common = require('awful.widget.common')
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
end

-- make focus_byidx work on all screens
-- kinda like focus_global_bydirection but here you can only press your usual two keys to go forward and backward the
-- clients list instead of having to really go with one of four directions
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

-- show a wibox, give it the given height and update its struts to only 1px bottom
-- this put the wibox on top of clients, kinda floating
function leimi.show_floating_wibox(w, height)
  w.height = height or 26
  w.ontop = true
  w:struts({ left = 0, right = 0, bottom = 1, top = 0 })
end

-- "hides" a wibox by setting its height to 1
-- this allows the mouse::enter signal to still work with the one pixel height
function leimi.hide_floating_wibox(w)
  w.height = 1
  w.ontop = false
  w:struts({ left = 0, right = 0, bottom = 1, top = 0 })
end

function leimi.toggle_floating_wibox(w, height)
  if w.height == 1 then
    leimi.show_floating_wibox(w, height)
  else
    leimi.hide_floating_wibox(w)
  end
end

-- custom option to pass to the tasklist - show only app icons
function leimi.icons_only_list(w, buttons, label, data, objects)
  w:reset()
  local icons_width = 0
  local l = wibox.layout.fixed.horizontal()
  for i, o in ipairs(objects) do
    local cache = data[o]
    if cache then
      ib = cache.ib
    else
      ib = wibox.widget.imagebox()
      ib:buttons(common.create_buttons(buttons, o))

      data[o] = {
        ib = ib
      }
    end

    local text, bg, bg_image, icon = label(o)
    ib:fit(24, 24)
    ib:set_image(icon)
    l:add(ib)
  end
  w:add(l)
end

return leimi