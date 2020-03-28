-- client keyboard shortcuts
client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({
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
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end),
    awful.key({ modkey,           }, "F12", function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c.maximized_vertical   = c.maximized_horizontal
      helpers.clients.update_client_colors(c)
    end),
    awful.key({ modkey            }, "y", function(c)
      awful.titlebar.toggle(c)
      helpers.clients.update_client_colors(c)
    end)
  })
end)
