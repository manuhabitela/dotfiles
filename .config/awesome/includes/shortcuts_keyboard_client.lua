-- client keyboard shortcuts
clientkeys = gears.table.join(
  awful.key({ modkey            }, "q",      function(c) c:kill() end),
  awful.key({ altkey            }, "F4",     function(c) c:kill() end),
  awful.key({ modkey            }, "u",      function(c)
    c.floating = not c.floating
    if c.floating then helpers.clients.show_titlebar_and_resize(c) else awful.titlebar.hide(c) end
  end),
  awful.key({ modkey, sft       }, "u",      function(c)
    c.sticky = not c.sticky
  end),
  awful.key({ modkey, sft, ctrl  }, "u",      function(c)
    c.ontop = not c.ontop
    c.sticky = c.ontop
    c.floating = c.ontop
  end),
  awful.key({ modkey,           }, "n",      function(c)
    c.minimized = true
  end),
  awful.key({ modkey,           }, "F11", function(c)
    c.maximized = not c.maximized
  end),
  awful.key({ modkey            }, "y", function(c)
    awful.titlebar.toggle(c)
  end),

  -- jklm to resize windows
  awful.key({ modkey,           }, "j", function(c)
    if helpers.screen.is_floating_layout() then
		c:relative_move(0, 0, -60, 0)
    else
      awful.tag.incmwfact(-0.05)
    end
  end),
  awful.key({ modkey,           }, "k", function(c)
    if helpers.screen.is_floating_layout() then
		c:relative_move(0, 0, 0, -30)
    else
      awful.client.incwfact(-0.1)
    end
  end),
  awful.key({ modkey,           }, "l", function(c)
    if helpers.screen.is_floating_layout() then
		c:relative_move(0, 0, 0, 30)
    else
      awful.client.incwfact( 0.1)
    end
  end),
  awful.key({ modkey,           }, "m", function(c)
    if helpers.screen.is_floating_layout() then
		c:relative_move(0, 0, 60, 0)
    else
      awful.tag.incmwfact( 0.05)
    end
  end),

  -- shift + jklm to move windows
  awful.key({ modkey, sft       }, "j", function(c)
    if helpers.screen.is_floating_layout() then
		c:relative_move(-60, 0, 0, 0)
	else
    	awful.client.swap.global_bydirection("left")
	end
  end),
  awful.key({ modkey, sft       }, "k", function(c)
    if helpers.screen.is_floating_layout() then
		c:relative_move(0, 30, 0, 0)
	else
    	awful.client.swap.global_bydirection("down")
	end
  end),
  awful.key({ modkey, sft       }, "l", function(c)
    if helpers.screen.is_floating_layout() then
		c:relative_move(0, -30, 0, 0)
	else
    	awful.client.swap.global_bydirection("up")
	end
  end),
  awful.key({ modkey, sft       }, "m", function(c)
    if helpers.screen.is_floating_layout() then
		c:relative_move(60, 0, 0, 0)
	else
    	awful.client.swap.global_bydirection("right")
	end
  end)
)
