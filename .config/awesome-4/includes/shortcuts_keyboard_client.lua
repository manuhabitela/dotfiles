-- client keyboard shortcuts
clientkeys = gears.table.join(
  awful.key({ modkey            }, "q",      function(c) c:kill() end),
  awful.key({ altkey            }, "F4",     function(c) c:kill() end),
  awful.key({ modkey            }, "u",      function(c)
    c.floating = not c.floating
    helpers.clients.update_client_colors(c)
  end),
  awful.key({ modkey, sft       }, "u",      function(c)
    c.ontop = not c.ontop
    c.sticky = c.ontop
    c.floating = c.ontop
    helpers.clients.update_client_colors(c)
  end),
  awful.key({ modkey,           }, "n",      function(c)
    c.minimized = true
  end),
  awful.key({ modkey,           }, "F12", function(c)
    c.maximized = not c.maximized
    helpers.clients.update_client_colors(c)
  end),
  awful.key({ modkey            }, "y", function(c)
    awful.titlebar.toggle(c)
    helpers.clients.update_client_colors(c)
  end)
)
