-- global keyboard shortcuts - work all the time everywhere

local volume_notification_cmd = "notify-send"
  .. " -i /home/manu/.config/awesome/themes/leimi/$(/home/manu/bin/pactl-notif-utils icon)"
  .. " -h string:x-canonical-private-synchronous:manu-volume"
  .. " -u low"
  .. " Volume \"$(/home/manu/bin/pactl-notif-utils text)\""

local mic_notification_cmd = "notify-send"
  .. " -i /home/manu/.config/awesome/themes/leimi/$(/home/manu/bin/pactl-notif-utils mic-icon)"
  .. " -h string:x-canonical-private-synchronous:manu-volume"
  .. " -u low"
  .. " \"$(/home/manu/bin/pactl-notif-utils mic-text)\""

globalkeys = gears.table.join(
  -- focus next or prev client - works accross all screens
  awful.key({ altkey, sft       }, "Tab",       function()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
  end),
  awful.key({ altkey,           }, "Tab",       function()
    awful.client.focus.byidx(1)
    if client.focus then client.focus:raise() end
  end),
  awful.key({ modkey, sft       }, "Tab",   function()
    if screen:count() > 1 then
      awful.screen.focus_relative(-1)
    else
      awful.client.focus.byidx(-1)
      if client.focus then client.focus:raise() end
    end
  end),
  awful.key({ modkey            }, "Tab",   function()
    if screen:count() > 1 then
      awful.screen.focus_relative(1)
    else
      awful.client.focus.byidx(1)
      if client.focus then client.focus:raise() end
    end
  end),

  -- jklm to resize windows
  awful.key({ modkey,           }, "j",       function() awful.tag.incmwfact(-0.05) end),
  awful.key({ modkey,           }, "k",       function() awful.client.incwfact(-0.1) end),
  awful.key({ modkey,           }, "l",       function() awful.client.incwfact( 0.1) end),
  awful.key({ modkey,           }, "m",       function() awful.tag.incmwfact( 0.05) end),

  -- shift + jklm to move windows
  awful.key({ modkey, sft       }, "j",       function() awful.client.swap.global_bydirection("left") end),
  awful.key({ modkey, sft       }, "k",       function() awful.client.swap.global_bydirection("down") end),
  awful.key({ modkey, sft       }, "l",       function() awful.client.swap.global_bydirection("up") end),
  awful.key({ modkey, sft       }, "m",       function() awful.client.swap.global_bydirection("right") end),

  -- add or remove focused client to the master side
  awful.key({ modkey,           }, "h",       function() awful.tag.incnmaster( 1) end),
  awful.key({ modkey, sft       }, "h",       function() awful.tag.incnmaster(-1) end),

  -- cycle through existing layouts
  awful.key({ modkey            }, "Return",  function()
    awful.layout.inc(1)
  end),
  awful.key({ modkey, sft       }, "Return",  function()
    awful.layout.inc(-1)
  end),

  awful.key({ modkey, sft       }, "y", function()
    local s = awful.screen.focused()
    local all_clients_have_titlebars = true
    local clients = s.selected_tag:clients()
    for k, c in ipairs(clients) do
      if all_clients_have_titlebars == true then
        local _, size = c.titlebar_top(c)
        all_clients_have_titlebars = size ~= 0
      end
    end
    for k, c in ipairs(clients) do
      if all_clients_have_titlebars then
        awful.titlebar.hide(c)
      else
        helpers.clients.show_titlebar_and_resize(c)
      end
    end
  end),

  -- run or raise applications
  awful.key({ modkey            }, "t",       function() awful.spawn(terminal) end),
  -- this shortcut is to pop a terminal in the current tag instead of moving it to tag 7 because of rules
  awful.key({ modkey, sft       }, "t",       function() awful.spawn(terminal .. " -T Roxterm-temp") end),

  awful.key({ modkey            }, "f",       function() helpers.launcher.ror("Thunar", { "Thunar" }) end),
  awful.key({ modkey            }, "s",       function() helpers.launcher.ror("subl", { "Code", "Sublime_text", "Subl" }) end),
  awful.key({ modkey, ctrl      }, "s",       function() helpers.launcher.ror("code", { "Code" }) end),
  awful.key({ modkey, sft       }, "s",       function() helpers.launcher.ror("subl", { "Sublime_text", "Subl" }) end),
  awful.key({ modkey            }, "w",       function()
    helpers.launcher.ror("firefox", { "firefox" })
  end),
  awful.key({ modkey            }, "g",       function() helpers.launcher.ror("git-cola", { "git-cola" }) end),

  awful.key({ modkey            }, "space",   function()
    awful.spawn.with_shell(helpers.string.replace(rofi_cmd, '{mode}', 'run'))
  end),

  awful.key({ modkey, altkey    }, "space",   function()
    awful.spawn.with_shell(helpers.string.replace(rofi_cmd, '{mode}', 'ssh'))
  end),

  awful.key({ modkey       }, "d",       function()
    awful.spawn.with_shell("rofi -modi emoji -show emoji -emoji-file /home/manu/.config/rofi/rofi-gitmoji/gitmoji_emojis.txt")
  end),

  awful.key({ modkey, sft }, "d",       function()
    awful.spawn.with_shell(calendar_widget_cmd)
  end),

  awful.key({ modkey }, "e",	function ()
    systray_hints.run()
  end),

  awful.key({ ctrl, altkey      }, "l",       function()
    awful.spawn.with_shell("slock")
  end),

  awful.key({ modkey, ctrl      }, "l",       function()
    awful.spawn.with_shell("slock")
  end),

  awful.key({ }, "XF86AudioLowerVolume",      function() awful.spawn.with_shell(
    "pactl set-sink-volume @DEFAULT_SINK@ -2% && " .. volume_notification_cmd
  ) end),
  awful.key({ }, "XF86AudioRaiseVolume",      function() awful.spawn.with_shell(
    "pactl set-sink-volume @DEFAULT_SINK@ +2% && " .. volume_notification_cmd
  ) end),
--   mute/unmute audio is a weird trick because I couldn't make it work easily with default stuff for some reason:
--   XF86AudioMicMute is usually mapped to a virtual F20 key. I used that on my qmk firmware without success
--   so my keyboard uses a virtual F15 key, which is usually mapped to XF86Launch6
--   but for some reason I couldn't map it in awesome
--   go check sxhkdrc for the keybinding working on my dz60 keyboard
-- the keybindings below are there when using keyboards that work…
  awful.key({ }, "XF86AudioMute",             function() awful.spawn.with_shell(
    "pactl set-sink-mute @DEFAULT_SINK@ toggle && sleep 0.1 && " .. volume_notification_cmd
  ) end),
  awful.key({ }, "XF86AudioMicMute",   function() awful.spawn.with_shell(ll
    "pactl set-source-mute @DEFAULT_SOURCE@ toggle && sleep 0.1 && " .. mic_notification_cmd
  ) end),

  awful.key({ }, "XF86MonBrightnessUp",       function() awful.spawn.with_shell(
    "brillo -u 100000 -A 5 && " ..
    "notify-send"
      .. " -i /home/manu/.config/awesome/themes/leimi/brightness.png"
      .. " -h string:x-canonical-private-synchronous:manu-brightness"
      .. " -u low"
      .. " Luminosité \"$(/home/manu/bin/progress-bar $(brillo -G) 15) $(echo $(brillo -G)/1 | bc) %\""
  ) end),
  awful.key({ }, "XF86MonBrightnessDown",     function() awful.spawn.with_shell(
    "brillo -u 100000 -U 5 && " ..
    "notify-send"
      .. " -i /home/manu/.config/awesome/themes/leimi/brightness.png"
      .. " -h string:x-canonical-private-synchronous:manu-brightness"
      .. " -u low"
      .. " Luminosité \"$(/home/manu/bin/progress-bar $(brillo -G) 15) $(echo $(brillo -G)/1 | bc) %\""
  ) end),

  awful.key({ modkey            }, "F7",      function() awful.spawn("/home/manu/bin/monitor-p14s switch") end),
  awful.key({ modkey, sft       }, "F7",      function() awful.spawn("/home/manu/bin/monitor-p14s in") end),
  awful.key({ modkey, ctrl      }, "F7",      function() awful.spawn("/home/manu/bin/monitor-p14s in") end),
  awful.key({ modkey, ctrl, sft }, "F7",      function() awful.spawn("/home/manu/bin/monitor-p14s out") end),
  awful.key({ modkey            }, "F12",     function() awful.spawn("/home/manu/bin/monitor-p14s in") end),

  awful.key({ modkey, ctrl      }, "r",       awesome.restart),
  awful.key({ modkey, ctrl, sft }, "q",       awesome.quit),

  awful.key({ altkey,           }, "space",   function()
    helpers.tags.toggle_tag(main_screen, 7);
  end)
)


-- bind all key numbers to tags
for i = 1, 9 do
  globalkeys = gears.table.join(globalkeys,
    -- switch to tag
    awful.key({ modkey       }, "#" .. i + 9, function()
      local s = awful.screen.focused()
      helpers.tags.toggle_tag(s, i)
    end),
    -- move focused client to tag
    awful.key({ modkey, sft  }, "#" .. i + 9, function()
      local s = client.focus.screen
      local tag = s.tags[i]
      if tag then
        local c = client.focus
        c:move_to_tag(tag)
        tag:view_only()
        client.focus = c
      end
    end),
    -- add focused client to tag
    awful.key({ modkey, ctrl }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end)
  )
end

root.keys(globalkeys)

