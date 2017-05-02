-- statusbar config: we have a systray, a launcher, a taglist and a tasklist
statusbars = {}
taglists = {}
tasklists = {}
-- normal taglist mouse buttons
taglists.buttons = awful.util.table.join(
  awful.button({ }, 1, awful.tag.viewonly),
  awful.button({ modkey }, 1, awful.client.movetotag),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, awful.client.toggletag),
  awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)
-- normal tasklist mouse buttons
tasklists.buttons = awful.util.table.join(
  awful.button({ }, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      -- Without this, the following
      -- :isvisible() makes no sense
      c.minimized = false
      if not c:isvisible() then
        awful.tag.viewonly(c:tags()[1])
      end
      -- This will also un-minimize
      -- the client, if needed
      client.focus = c
      c:raise()
    end
  end),
  awful.button({ }, 3, function()
    if instance then
      instance:hide()
      instance = nil
    else
      instance = awful.menu.clients({
      theme = { width = 250 }
      })
    end
  end),
  awful.button({ }, 4, function()
    awful.client.focus.byidx(1)
    if client.focus then client.focus:raise() end
  end),
  awful.button({ }, 5, function()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
  end)
)


local statusbar_items_separator = wibox.widget.textbox()
local statusbar_options = { position = "bottom", bg = beautiful.statusbar_bg_color, border_width = beautiful.statusbar_border_width, border_color = beautiful.statusbar_border_color, align = "right", height = 26 }
local statusbar_systray_options = { bg = "#00000000", height = 28, border_width = 0, width = 300 }
local statusbar_systray = wibox(awful.util.table.join(statusbar_options, statusbar_systray_options))
statusbar_items_separator:set_font("Noto Sans 9")
statusbar_items_separator:set_valign("center")
statusbar_items_separator:set_markup('<span foreground="'..beautiful.statusbar_separator_color..'">|</span>')
for s = 1, screen.count() do
  local statusbar_layout = wibox.layout.align.horizontal()
  statusbars[s] = awful.wibox(awful.util.table.join(statusbar_options, { screen = s }))
  taglists[s] = awful.widget.taglist(s, function(t) return t.name ~= "7" end, taglists.buttons)

  -- we show apps in the tasklist with icons only
  tasklists[s] = awful.widget.tasklist(
    s,
    awful.widget.tasklist.filter.alltags,
    tasklists.buttons,
    nil,
    helpers.tasklist.names_only_list,
    wibox.layout.fixed.horizontal()
  )

  tasklists[s].border_color = beautiful.statusbar_border_color
  tasklists[s].border_width = 1
  -- show systray, clock and menu on main screen only - others screen have just their taglist and tasklist
  if s == main_screen then
    local statusbar_layout_right = wibox.layout.fixed.horizontal()
    local statusbar_layout_left = wibox.layout.fixed.horizontal()

    statusbar_current_layout_name = wibox.widget.textbox( awful.layout.getname())
    statusbar_current_layout_name:fit(50, 50)

    local menutext = wibox.widget.textbox('menu')
    menutext:buttons(awful.button({ }, 1, function() main_menu:toggle() end))
    statusbar_layout_left:add( wibox.layout.margin(menutext, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin) )
    statusbar_layout_left:add( statusbar_items_separator )

    local clock = awful.widget.textclock("%H:%M", 10)
    clock:set_font(beautiful.clock_font)
    statusbar_layout_left:add( wibox.layout.margin(clock, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin) )
    statusbar_layout_left:add( statusbar_items_separator )

    local date = awful.widget.textclock("%d/%m", 10)
    date:set_font(beautiful.clock_font)
    statusbar_layout_left:add( wibox.layout.margin(date, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin) )
    statusbar_layout_left:add( statusbar_items_separator )

    statusbar_layout_left:add( wibox.layout.margin(taglists[s], beautiful.statusbar_items_margin) )
    statusbar_layout_left:add( wibox.layout.margin(statusbar_items_separator, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin/2) )

    statusbar_layout_left:add( wibox.layout.margin(statusbar_current_layout_name, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin+2) )
    statusbar_layout_left:add( statusbar_items_separator )

    statusbar_layout_left:add(wibox.layout.margin(tasklists[s], beautiful.statusbar_items_margin, beautiful.statusbar_items_margin))

    local mysystray = wibox.widget.systray()
    mysystray:set_base_size(beautiful.statusbar_height - beautiful.statusbar_margin)
    mysystray:fit()

    statusbar_layout_right:add(mysystray)
    statusbar_layout:set_right(statusbar_layout_right)
    statusbar_layout:set_left(statusbar_layout_left)
  else
    local statusbar_layout_left = wibox.layout.fixed.horizontal()

    statusbar_layout_left:add( wibox.layout.margin(taglists[s], 0, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin) )

    statusbar_layout_left:add( wibox.layout.margin(tasklists[s], 0, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin) )

    statusbar_layout:set_left(statusbar_layout_left)
  end
  statusbars[s]:set_widget(wibox.layout.margin(statusbar_layout, beautiful.statusbar_margin, beautiful.statusbar_margin, beautiful.statusbar_margin, beautiful.statusbar_margin))
end