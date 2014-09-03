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

function leimi.update_border_color(c)
  if c.maximized then
    c.border_color = beautiful.border_maximized
  elseif awful.client.floating.get(c) then
    c.border_color = beautiful.border_floating
  elseif client.focus == c then
    c.border_color = beautiful.border_focus
  else
    c.border_color = beautiful.border_normal
  end
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

function leimi.filter_visible_clients(current_screen, current_client)
  local visible_clients = awful.client.visible(current_screen)
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
-- kinda like focus_global_bydirection but here you can only press your usual two keys to go
-- forward and backward the clients list instead of having to really go with one of four directions
-- and it cycles (I use it as an alt-tab alternative)
function leimi.client_focus_global_byidx(i, c)
  local multiple_screens = screen.count() > 1
  local current_client = c or client.focus
  local current_screen = current_client and current_client.screen or mouse.screen
  local visible_clients = leimi.filter_visible_clients(current_screen, current_client)
  local next_client = awful.client.next(i, current_client)

  if multiple_screens and current_client == visible_clients[1] and i == -1 then
    awful.screen.focus_relative(-1)
    local new_visible_clients = leimi.filter_visible_clients(client.focus.screen, client.focus)
    client.focus = new_visible_clients[#new_visible_clients]
  elseif multiple_screens and current_client == visible_clients[#visible_clients] and i == 1 then
    awful.screen.focus_relative(1)
    local new_visible_clients = leimi.filter_visible_clients(client.focus.screen, client.focus)
    client.focus = new_visible_clients[1]
  elseif next_client then
    client.focus = next_client
  end
end

-- show a wibox, give it the given height and update its struts to only 1px bottom
-- this put the wibox on top of clients, kinda floating
function leimi.show_floating_wibox(w, height)
  height = height or 26
  if w.height ~= height then
    w.height = height
    w.ontop = true
    w:struts({ left = 0, right = 0, bottom = 1, top = 0 })
  end
end

-- "hides" a wibox by setting its height to 1
-- this allows the mouse::enter signal to still work with the one pixel height
function leimi.hide_floating_wibox(w)
  if w.height ~= 1 then
    w.height = 1
    w.ontop = false
    w:struts({ left = 0, right = 0, bottom = 1, top = 0 })
  end
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
    local ib, m
    if cache then
      ib = cache.ib
      m = cache.m
      bgb = cache.bgb
    else
      ib = wibox.widget.imagebox()
      bgb = wibox.widget.background()
      m = wibox.layout.margin(ib, 2, 2, 1, 1)

      bgb:set_widget(m)
      bgb:buttons(common.create_buttons(buttons, o))

      data[o] = {
        ib = ib,
        bgb = bgb,
        m = m
      }
    end

    local text, bg, bg_image, icon = label(o)
    bgb:set_bg(bg)
    bgb:set_bgimage(bg_image)
    local icon_size = beautiful.statusbar_height - beautiful.statusbar_margin
    ib:fit(icon_size, icon_size)
    ib:set_image(icon)
    l:add(bgb)
  end
  w:add(l)
end

function leimi.ror(cmd, classes, merge)
  if classes and type(classes) ~= "table" then
    classes = { classes }
  end
  local matcher = function(c)
    return awful.rules.match_any(c, { class = classes })
  end
  return awful.client.run_or_raise(cmd, matcher, merge)
end

return leimi