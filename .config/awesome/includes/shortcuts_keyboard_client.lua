-- client keyboard shortcuts
clientkeys = awful.util.table.join(
  awful.key({ modkey            }, "q",      function(c) c:kill() end),
  awful.key({ altkey            }, "F4",     function(c) c:kill() end),
  awful.key({ modkey            }, "u",      function(c)
    awful.client.floating.toggle(c)
    helpers.clients.update_client_colors(c)
  end),
  awful.key({ modkey,           }, "n",      function(c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
  end),
  awful.key({ modkey,           }, "F12", function(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c.maximized_vertical   = not c.maximized_vertical
    helpers.clients.update_client_colors(c)
  end),
  awful.key({ modkey            }, "y", function(c)
    awful.titlebar.toggle(c)
    helpers.clients.update_client_colors(c)
  end)
)