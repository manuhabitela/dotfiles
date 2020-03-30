-- mouse buttons that works on a client - redefine the global mouse bindings for client behavior
clientbuttons = gears.table.join(
  awful.button({ }, 1, function(c)
    if awful.client.focus.filter(c) then
      client.focus = c
    end
    c:raise()
  end),
  awful.button({ modkey }, 1, awful.mouse.client.move),
  awful.button({ modkey }, 3, awful.mouse.client.resize)
)
