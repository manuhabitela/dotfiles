-- global keyboard shortcuts - work all the time everywhere
globalkeys = gears.table.join(
  -- focus next or prev client - works accross all screens
  awful.key({ altkey, sft       }, "Tab",       function()
    helpers.clients.client_focus_global_byidx(-1)
    if client.focus then client.focus:raise() end
  end),
  awful.key({ altkey,           }, "Tab",       function()
    helpers.clients.client_focus_global_byidx(1)
    if client.focus then client.focus:raise() end
  end),

  -- focus next or prev client - works accross all screens
  awful.key({ modkey, sft       }, "Tab",       function()
    helpers.clients.client_focus_global_byidx(-1)
    if client.focus then client.focus:raise() end
  end),
  awful.key({ modkey,           }, "Tab",       function()
    helpers.clients.client_focus_global_byidx(1)
    if client.focus then client.focus:raise() end
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

  -- run or raise applications
  awful.key({ modkey            }, "t",       function() awful.spawn(terminal) end),
  awful.key({ modkey            }, "f",       function() helpers.launcher.ror("pcmanfm", "Pcmanfm") end),
  awful.key({ modkey            }, "s",       function() helpers.launcher.ror("subl", { "Sublime_text", "Subl" }) end),
  awful.key({ modkey            }, "w",       function()
    helpers.launcher.ror("google-chrome-stable", "Google-chrome")
  end),
  awful.key({ modkey            }, "g",       function() helpers.launcher.ror("git-cola", "git-cola") end),

  -- dmenu with fuzzy matching through -z option https://aur.archlinux.org/packages/dmenu-xft-fuzzy/
  awful.key({ modkey            }, "space",   function()
    awful.spawn.with_shell(string.format(
      "dmenu_run_aliases -fn '%s' -nf '%s' -nb '%s' -sf '%s' -sb '%s' -l 15 -i -z",
      beautiful.font_dmenu, beautiful.fg_normal, beautiful.bg_normal, beautiful.fg_focus, beautiful.bg_focus
    ))
  end),

  awful.key({ modkey            }, "d",       function()
    awful.spawn.with_shell(calendar_widget_cmd)
  end),

  awful.key({ ctrl, altkey      }, "l",       function()
    awful.spawn.with_shell("slock")
  end),

  awful.key({ }, "XF86AudioLowerVolume",      function() awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ -5% && notify-send -i /home/manu/.config/awesome/themes/leimi/volume-low.png -h string:x-canonical-private-synchronous:manu-volume -u low Volume $(/home/manu/bin/pactl-utils current)%") end),
  awful.key({ }, "XF86AudioRaiseVolume",      function() awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ +5% && notify-send -i /home/manu/.config/awesome/themes/leimi/volume-high.png -h string:x-canonical-private-synchronous:manu-volume -u low Volume $(/home/manu/bin/pactl-utils current)%") end),
  awful.key({ }, "XF86AudioMute",             function() awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ toggle && sleep 0.1 && notify-send -h string:x-canonical-private-synchronous:manu-volume -u low Volume \"$(/home/manu/bin/pactl-utils muted)\"") end),

  awful.key({ }, "XF86MonBrightnessUp",       function() awful.spawn.with_shell("brillo -u 100000 -A 5 && notify-send -i /home/manu/.config/awesome/themes/leimi/brightness.png -h string:x-canonical-private-synchronous:manu-brightness -u low Luminosité $(brillo -G)%") end),
  awful.key({ }, "XF86MonBrightnessDown",     function() awful.spawn.with_shell("brillo -u 100000 -U 5 && notify-send -i /home/manu/.config/awesome/themes/leimi/brightness.png -h string:x-canonical-private-synchronous:manu-brightness -u low Luminosité $(brillo -G)%") end),

  awful.key({ modkey            }, "F7",      function() awful.spawn("/home/manu/bin/monitor switch") end),
  awful.key({ modkey, ctrl      }, "m",       function() awful.spawn("/home/manu/bin/monitor switch") end),
  awful.key({ modkey, ctrl      }, "r",       awesome.restart),
  awful.key({ modkey, ctrl, sft }, "q",       awesome.quit),

  awful.key({ altkey,           }, "space",   function()
    helpers.tags.toggle_tag(main_screen, 7);
  end)
)


-- bind all key numbers to tags
for i = 1, 9 do
  globalkeys = gears.table.join(globalkeys,
    awful.key({ modkey       }, "#" .. i + 9, function()
      local s = awful.screen.focused()
      helpers.tags.toggle_tag(s, i)
    end),
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
    awful.key({ modkey, ctrl }, "#" .. i + 9, function()
      local s = awful.screen.focused()
      local tag = s.tags[i]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end)
  )
end

root.keys(globalkeys)

