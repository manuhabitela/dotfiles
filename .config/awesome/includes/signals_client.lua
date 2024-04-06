-- signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  helpers.wallpaper.update(c.screen)

  -- keep everything not a terminal out of the terminal-specific tag
  if c.screen == main_screen and c.first_tag.name == terminal_tag and not gears.table.hasitem(terminal_tag_classes, c.class) then
    helpers.clients.move_out_to(c, c.screen.tags[3])
  end

  -- all those rules below are to put specific apps on specific tag only if
  -- I dont have a window of this app already opened.
  -- usually I'd have those apps opened on those specific tags,
  -- and if I want a new window of it I want it to be opened on the current tag
  if gears.table.hasitem(code_editor_classes, c.class) and helpers.clients.count_instances(c) == 1 then
    helpers.clients.move_out_to(c, screen.primary.tags[2])
  end

  if gears.table.hasitem(browser_classes, c.class) and helpers.clients.count_instances(c) == 1 then
    -- helpers.clients.move_out_to(c, screen.primary.tags[big_screen and 2 or 3])
    helpers.clients.move_out_to(c, screen.primary.tags[3])
  end

  if c.class == "git-cola" and helpers.clients.count_instances(c) == 1 then
    helpers.clients.move_out_to(c, screen.primary.tags[4])
  end

  if gears.table.hasitem(other_screen_classes, c.class) and helpers.clients.count_instances(c) == 1 then
    helpers.clients.move_out_to(c, (other_screen and other_screen or main_screen).tags[1] )
  end

  if gears.table.hasitem(terminal_tag_classes, c.class)
    and not gears.table.hasitem(terminal_app_names, c.name)
    and helpers.clients.count_instances(c) == 1 then
    helpers.clients.move_out_to(c, screen.primary.tags[7])
  end

  if c.name:find('Android Emulator - ') then
    c.floating = true
  end
  -- end of app-specific rules

  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
  end
end)

client.connect_signal("request::titlebars", function(c)
  local buttons = gears.table.join(
    awful.button({ }, 1, function()
      c:emit_signal("request::activate", "titlebar", {raise = true})
      awful.mouse.client.move(c)
    end),
    awful.button({ }, 3, function()
      c:emit_signal("request::activate", "titlebar", {raise = true})
      awful.mouse.client.resize(c)
    end)
  )

  local left_layout = wibox.layout.fixed.horizontal()
  local titlewidget = awful.titlebar.widget.titlewidget(c)
  titlewidget:set_font(beautiful.titlebar_font)
  left_layout:add(wibox.container.margin(titlewidget, 10, 0, 0, 1))
  left_layout:buttons(buttons)
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
--   local clientbg= get_dominant_color(c)
--   local textcolor = is_contrast_acceptable(beautiful.colors.white, clientbg) and beautiful.colors.white or "#222"
--   awful.titlebar(c, { size = beautiful.titlebar_size, bg_focus = clientbg, bg_normal = clientbg, fg_focus = textcolor, fg_normal = textcolor }):set_widget(layout)
  awful.titlebar(c, { size = beautiful.titlebar_size }):set_widget(layout)
end)

client.connect_signal("focus", function(c)
  c.border_color = beautiful.border_focus
end)

client.connect_signal("unfocus", function(c)
  c.border_color = beautiful.border_normal
end)

client.connect_signal("button::press", function(c)
  main_menu:hide()
end)

client.connect_signal("focus", function(c)
  main_menu:hide()
end)

client.connect_signal("unmanage", function(c)
  helpers.wallpaper.update(c.screen)
end)

client.connect_signal("property::minimized", function(c)
  helpers.wallpaper.update(c.screen)
end)

client.connect_signal("property::name", function(c)
  if c.name:find('Android Emulator - ') then
    c.floating = true
  end
end)
