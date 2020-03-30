local statusbar_items_separator = wibox.widget.textbox()
statusbar_items_separator:set_font("Noto Sans 9")
statusbar_items_separator:set_valign("center")
statusbar_items_separator:set_markup('<span foreground="'..beautiful.statusbar_separator_color..'">|</span>')
local statusbar_options = {
  position = "bottom",
  bg = beautiful.statusbar_bg_color,
  border_width = beautiful.statusbar_border_width,
  border_color = beautiful.statusbar_border_color,
  align = "right",
  height = 26
}
local statusbar_systray_options = {
  bg = "#00000000",
  height = 28,
  border_width = 0,
  width = 300
}
local statusbar_systray = wibox(awful.util.table.join(statusbar_options, statusbar_systray_options))

local taglist_buttons = awful.util.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = awful.util.table.join(
  awful.button({ }, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      -- Without this, the following
      -- :isvisible() makes no sense
      c.minimized = false
      if not c:isvisible() then
        c.first_tag:view_only()
      end
      -- This will also un-minimize
      -- the client, if needed
      client.focus = c
      c:raise()
    end
  end),
  awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
  awful.button({ }, 4, function()
    awful.client.focus.byidx(1)
    if client.focus then client.focus:raise() end
  end),
  awful.button({ }, 5, function()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
  end)
)

local gstring = require("gears.string")
local function tasklist_client_name(c)
  local name = helpers.string.replace(c.class:lower(), "_", "-")
  if c.minimized then
    return "-" .. name
  end
  return gstring.xml_escape(name)
end
local tasklist_template = {
  {
    id = "text_role",
    widget = wibox.widget.textbox
  },
  id = "text_margin_role",
  left = 4,
  right = 4,
  widget = wibox.container.margin
}

screen.connect_signal("property::geometry", helpers.wallpaper.update)

awful.screen.connect_for_each_screen(function(s)
  helpers.wallpaper.update(s)

  -- if on big screen, we default to the "bspwm-like" layout (spiral.dwindle), otherwise default to tile
  -- always use tile by default on the roxterm specific layout
  local default_layout = helpers.screen.is_big(s) and awful.layout.layouts[2] or awful.layout.layouts[1]
  awful.tag({ "1", "2", "3", "4", "5", "6", "7" }, s, {default_layout, default_layout, default_layout, default_layout, default_layout, default_layout, awful.layout.layouts[1]})

  local statusbar_widget = awful.wibar(awful.util.table.join(statusbar_options, { screen = s }))

  local taglist_widget = awful.widget.taglist(s, function(t) return t.name ~= "7" end, taglist_buttons)
  local tasklist_widget = helpers.tasklist_widget({
    screen = s,
    filter = awful.widget.tasklist.filter.alltags,
    buttons = tasklist_buttons,
    style = {
      client_name_function = tasklist_client_name
    },
    layout = wibox.layout.fixed.horizontal(),
    widget_template = tasklist_template
  })

  -- show systray, clock and menu on main screen only - others screen have just their taglist and tasklist
  local statusbar_layout = wibox.layout.align.horizontal()
  if s == screen.primary then
    local statusbar_layout_right = wibox.layout.fixed.horizontal()
    local statusbar_layout_left = wibox.layout.fixed.horizontal()

    s.statusbar_current_layout_name = wibox.widget.textbox(awful.layout.getname())
    s.statusbar_current_layout_name.align = 'center'
    s.statusbar_current_layout_name.forced_width = beautiful.statusbar_current_layout_width

    local menutext = wibox.widget.textbox('menu')
    menutext:buttons(awful.button({ }, 1, function() main_menu:toggle() end))
    statusbar_layout_left:add( wibox.container.margin(menutext, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin) )
    statusbar_layout_left:add( statusbar_items_separator )

    local clock = wibox.widget.textclock("%H:%M", 10)
    clock:set_font(beautiful.clock_font)
    clock.align = 'center'
    clock.forced_width = beautiful.clock_width
    statusbar_layout_left:add( wibox.container.margin(clock, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin) )
    statusbar_layout_left:add( statusbar_items_separator )

    local date = wibox.widget.textclock("%d/%m", 10)
    date:set_font(beautiful.clock_font)
    date.align = 'center'
    date.forced_width = beautiful.date_width
    statusbar_layout_left:add( wibox.container.margin(date, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin) )
    statusbar_layout_left:add( statusbar_items_separator )

    statusbar_layout_left:add( wibox.container.margin(taglist_widget, beautiful.statusbar_items_margin) )
    statusbar_layout_left:add( wibox.container.margin(statusbar_items_separator, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin/2) )

    statusbar_layout_left:add( wibox.container.margin(s.statusbar_current_layout_name, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin+2) )
    statusbar_layout_left:add( statusbar_items_separator )

    statusbar_layout_left:add(wibox.container.margin(tasklist_widget, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin))

    local mysystray = wibox.widget.systray()
    mysystray:set_base_size(beautiful.statusbar_height - beautiful.statusbar_margin)
    mysystray:fit({dpi = s.dpi })

    statusbar_layout_right:add(mysystray)
    statusbar_layout:set_right(statusbar_layout_right)
    statusbar_layout:set_left(statusbar_layout_left)
  else
    local statusbar_layout_left = wibox.layout.fixed.horizontal()

    statusbar_layout_left:add( wibox.container.margin(taglist_widget, 0, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin) )

    statusbar_layout_left:add( wibox.container.margin(tasklist_widget, 0, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin) )

    statusbar_layout:set_left(statusbar_layout_left)
  end
  statusbar_widget:set_widget(wibox.container.margin(statusbar_layout, beautiful.statusbar_margin_horizontal, beautiful.statusbar_margin_horizontal, beautiful.statusbar_margin_top, beautiful.statusbar_margin_bottom))
end)

screen.connect_signal("primary_changed", function(s)
  big_screen = screen.primary.geometry.width > 2500 and screen.primary.geometry.height > 1400
end)
