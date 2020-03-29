-- signal function to execute when a new client appears.
client.connect_signal("request::manage", function(c)
  if c.first_tag.name == "7" and c.class ~= "Roxterm" and c.class ~= "roxterm" then
    c:move_to_tag(screen[main_screen].tags[3], c)
    screen[main_screen].tags[3]:view_only()
  end
end)

client.connect_signal("request::titlebars", function(c)
  local buttons = {
    awful.button({ }, 1, function()
      c:activate { context = "titlebar", action = "mouse_move"  }
    end),
    awful.button({ }, 3, function()
      c:activate { context = "titlebar", action = "mouse_resize"}
    end),
  }

  local left_layout = wibox.layout.fixed.horizontal()
  left_layout:add(wibox.container.margin(awful.titlebar.widget.titlewidget(c), 10, 0, 0, 1))
  left_layout:buttons(mouse_buttons)
  local right_layout = wibox.layout.fixed.horizontal()
  local title_buttons = {
    awful.titlebar.widget.minimizebutton(c),
    awful.titlebar.widget.maximizedbutton(c),
    awful.titlebar.widget.closebutton(c)
  }
  for i, title_button in ipairs(title_buttons) do
    right_layout:add(title_button)
  end
  local layout = wibox.layout.align.horizontal()
  layout:set_left(left_layout)
  layout:set_right(right_layout)
  awful.titlebar(c, { size = beautiful.titlebar_size }):set_widget(layout)
end)

-- change client's border on focus change
client.connect_signal("focus", function(c)
  helpers.clients.update_client_colors(c)
end)

client.connect_signal("unfocus", function(c)
  helpers.clients.update_client_colors(c)
end)

client.connect_signal("button::press", function(c)
  main_menu:hide()
end)

client.connect_signal("focus", function(c)
  main_menu:hide()
end)
