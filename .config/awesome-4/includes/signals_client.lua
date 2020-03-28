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

  awful.titlebar(c, { size = 18 }).widget = {
    { -- Left
      awful.titlebar.widget.titlewidget(c),
      buttons = buttons,
      layout  = wibox.layout.fixed.horizontal
    },
    { -- Right ? or middle maybe
      awful.titlebar.widget.minimizebutton(c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.closebutton(c)
      layout = wibox.layout.fixed.horizontal()
    },
    layout = wibox.layout.align.horizontal
  }
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
