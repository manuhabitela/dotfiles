-- signal function to execute when a new client appears.
client.connect_signal("manage", function(c, startup)
  if not startup then
    -- set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    awful.client.setslave(c)

    -- put windows in a smart way, only if they does not set an initial position.
    if not c.size_hints.user_position and not c.size_hints.program_position then
      awful.placement.no_overlap(c)
      awful.placement.no_offscreen(c)
    end
  end

  if c:tags()[1].name == "7" and c.class ~= "Roxterm" and c.class ~= "roxterm" then
    awful.client.movetotag( tags[main_screen][3], c )
    awful.tag.viewonly( tags[main_screen][3] )
  end

  -- titlebar - for some clients we do not want it (their class or instance name is in a blacklist)
  if (c.type == "normal" or c.type == "dialog") and c.name then
    -- buttons working when clicking the titlebar text on the left (left click = move, right click = resize)
    local mouse_buttons = awful.util.table.join(
      awful.button({ }, 1, function()
        if awful.client.focus.filter(c) then
          client.focus = c
        end
        c:raise()
        awful.mouse.client.move(c)
      end),
      awful.button({ }, 3, function()
        if awful.client.focus.filter(c) then
          client.focus = c
        end
        c:raise()
        awful.mouse.client.resize(c)
      end)
    )

    -- name of the client on the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(helpers.titlebar.titlewidget(c))
    left_layout:buttons(mouse_buttons)

    -- clickable buttons to minimize, maximize and close client on the right
    local right_layout = wibox.layout.fixed.horizontal()
    local title_buttons = {
      awful.titlebar.widget.minimizebutton(c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.closebutton(c)
    }
    for i, title_button in ipairs(title_buttons) do
      -- disable resize if icons are too blurry
      -- title_button:set_resize(false)
      right_layout:add(title_button)
    end

    -- create the layout containing left/right sides, set the titlebar with a given size
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_right(right_layout)
    awful.titlebar(c, { size = 18 }):set_widget(layout)
    if not awful.client.floating.get(c) then
      awful.titlebar.hide(c)
    end
  end
end)

-- change client's border on focus change
-- be sure the menu and statusbar are hidden when we are a on client (focusing it or clicking on it)
client.connect_signal("focus", function(c)
  helpers.clients.update_client_colors(c)
 end)


client.connect_signal("unfocus", function(c)
  helpers.clients.update_client_colors(c)
end)