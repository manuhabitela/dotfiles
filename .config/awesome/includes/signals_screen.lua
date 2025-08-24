local statusbar_items_separator = wibox.widget.textbox()
statusbar_items_separator:set_font("Noto Sans 9")
statusbar_items_separator:set_valign("center")
statusbar_items_separator:set_markup('<span foreground="'..beautiful.statusbar_separator_color..'">|</span>')
local statusbar_options = {
  type="dock",
  ontop = true,
  visible = true,
  position = "bottom",
  bg = beautiful.statusbar_bg_color,
  border_width = beautiful.statusbar_border_width,
  border_color = beautiful.statusbar_border_color,
  height = beautiful.statusbar_height
}

local taglist_buttons = awful.util.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = awful.util.table.join(
  awful.button({ }, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      -- Without this, the following
      -- :isvisible() makes no sense
      c.minimized = false
      if not c:isvisible() then
        c.first_tag:view_only()
      end
      -- This will also un-minimize
      -- the client, if needed
      client.focus = c
      c:raise()
    end
  end),
  awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
  awful.button({ }, 4, function()
    awful.client.focus.byidx(1)
    if client.focus then client.focus:raise() end
  end),
  awful.button({ }, 5, function()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
  end)
)

local names_mapping = {
  ["sublime-text"] = "subl",
  ["roxterm"] = "term",
  ["Roxterm-temp"] = "term",
  ["google-chrome"] = "chrome",
  ["firefox"] = "firefox",
  ["spotify"] = "spotify",
  ["spotify-tui"] = "spotify tui",
  ["git-cola"] = "git cola",
  ["pcmanfm"] = "fichiers",
  ["gimp-2.10"] = "gimp",
  ["eog"] = "eog",
  ["vlc"] = "VLC",
  ["evince"] = "evince",
  ["file-roller"] = "archive",
  ["libreoffice"] = "libreoffice",
  ["libreoffice-writer"] = "libreoffice",
  ["libreoffice-calc"] = "libreoffice"
}
local short_names_count = {}
local function short_client_name(c)
  local name = "untitled"
  if c.name and gears.table.hasitem(terminal_app_names, c.name) then
    name = c.name
  elseif c.class then
    name = helpers.string.replace(c.class:lower(), "_", "-")
  end
  if names_mapping[name] then
    name = names_mapping[name]
  end
  return name
end

local function tasklist_client_name(c, all_clients)
  local name = short_client_name(c)
--   if short_names_count[name]
--     and short_names_count[name] > 1
--     and c.name
--   then
--     name = name .. ': '
--       .. helpers.string.sub8(c.name, 0, c.name:len() > 15 and 15 or c.name:len())
--       .. (c.name:len() > 15 and '…' or '')
--   end
  if c.minimized then
    return "-" .. name
  end

  local tag = c.first_tag.index
  if tag == 1 then name = name .. ' ⑴' end
  if tag == 2 then name = name .. ' ⑵' end
  if tag == 3 then name = name .. ' ⑶' end
  if tag == 4 then name = name .. ' ⑷' end
  if tag == 5 then name = name .. ' ⑸' end
  if tag == 6 then name = name .. ' ⑹' end
  if tag == 7 then name = name .. ' ⑺' end

  return gears.string.xml_escape(name)
end

local tasklist_template = {
  {
    id = "text_role",
    widget = wibox.widget.textbox
  },
  id = "text_margin_role",
  left = 6,
  right = 6,
  widget = wibox.container.margin
}

-- show the clients ordered as they are shown on the screen:
--  first show the clients in tag 1, then tag 2, then tag 3, etc
--  clients in same tag are shown as they appear in the tag: first master, then slave 1, slave 2, etc
local function tasklist_source(s, args)
  local clients = s.all_clients
  local tag_clients_cache = {}
  table.sort(clients, function(a, b)
    if a.sticky then
      return true
    end
    if b.sticky then
      return false
    end
    if a.first_tag.name == b.first_tag.name then
      if not tag_clients_cache[a.first_tag.name] then
        tag_clients_cache[a.first_tag.name] = a.first_tag:clients()
      end
      local tag_clients = tag_clients_cache[a.first_tag.name]
      local a_position = gears.table.find_first_key(tag_clients, function(k, v) return v == a end)
      local b_position = gears.table.find_first_key(tag_clients, function(k, v) return v == b end)
      return a_position < b_position
    end
    return a.first_tag.name < b.first_tag.name
  end)

  short_names_count = {}
  for k,v in ipairs(clients) do
    local short_name = short_client_name(v)
    if short_names_count[short_name] == nil then
      short_names_count[short_name] = 0
    end
    short_names_count[short_name] = short_names_count[short_name] + 1
  end

  return clients
end

screen.connect_signal("property::geometry", helpers.wallpaper.update)

awful.screen.connect_for_each_screen(function(s)
  helpers.wallpaper.update(s)

  -- the "7" tag, which is reserved for the terminal, is only on the main screen
  local screen_tags = { "1", "2", "3", "4", "5", "6" }
  local tile_layout = awful.layout.layouts[3]
  local max_layout = awful.layout.layouts[1]
  local cascade_layout = awful.layout.layouts[4]
  local float_layout = awful.layout.layouts[5]
  if s == main_screen then
    table.insert(screen_tags, "7")
    awful.tag(screen_tags, s, {cascade_layout, tile_layout, tile_layout, tile_layout, float_layout, float_layout, tile_layout})
  else
    awful.tag(screen_tags, s, {cascade_layout, cascade_layout, cascade_layout, cascade_layout, cascade_layout, cascade_layout, cascade_layout})
  end

  local statusbar_widget = awful.wibar(awful.util.table.join(statusbar_options, {
    screen = s,
    -- width = s.geometry.width,
    -- y = s.geometry.height - beautiful.statusbar_height
  }))

  local hidden_statusbar_widget = wibox({
    type = "dock",
    ontop = true,
    visible = false,
    height = 10,
    width = 300,
    y = s.geometry.height - 10,
    x = 0,
    bg = beautiful.colors.blue_very_dark_transparent,
    fg = "white"
  })
  local hidden_statusbar_layout = wibox.layout.fixed.horizontal()
  local hidden_statusbar_text = s.selected_tag.index
  local hidden_statusbar_text_widget = wibox.widget.textbox(hidden_statusbar_text)
  hidden_statusbar_text_widget:set_font(beautiful.fonts.small)
  hidden_statusbar_layout:add(hidden_statusbar_text_widget)
  hidden_statusbar_widget:set_widget(wibox.container.margin(hidden_statusbar_layout, 40, 2, 0, 1))

  s.statusbar_widget = statusbar_widget
  s.hidden_statusbar_widget = hidden_statusbar_widget
--  beautiful.gap_single_client = not s.statusbar_widget.visible
  local taglist_widget = awful.widget.taglist(s, function(t) return t.name ~= "7" end, taglist_buttons)
  local tasklist_widget = helpers.tasklist_widget({
    screen = s,
    filter = awful.widget.tasklist.filter.alltags,
    buttons = tasklist_buttons,
    source = tasklist_source,
    style = {
      client_name_function = function(c) return tasklist_client_name(c, tasklist_source) end
    },
    layout = wibox.layout.fixed.horizontal(),
    widget_template = tasklist_template
  })

  local statusbar_layout = wibox.layout.align.horizontal()
  local statusbar_layout_left = wibox.layout.fixed.horizontal()

  s.statusbar_current_layout_name = wibox.widget.textbox(awful.layout.getname())
  s.statusbar_current_layout_name:set_font(beautiful.statusbar_font)
  s.statusbar_current_layout_name.align = 'center'
  s.statusbar_current_layout_name.forced_width = beautiful.statusbar_current_layout_width

  local clock = wibox.widget.textclock("%H:%M", 10)
  clock:set_font(beautiful.statusbar_font)
  clock.align = 'center'
  clock.forced_width = beautiful.clock_width
  statusbar_layout_left:add( wibox.container.margin(clock, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin) )
  statusbar_layout_left:add( statusbar_items_separator )

  local date = wibox.widget.textclock("%a. %d %b", 10)
  date:buttons(awful.util.table.join(
    awful.button({ }, 1, function() awful.spawn.with_shell(calendar_widget_cmd) end)
  ))
  date:connect_signal("widget::redraw_needed", function()
    local day = helpers.date.french_day(os.date('%a'))
    local month = helpers.date.french_month(os.date('%b'))
    local day_num = helpers.date.no_leading_zero_day_num(os.date('%d'))
    date.text = day .. ". " .. day_num .. " " .. month
  end)
  date:set_font(beautiful.statusbar_font)
  date.align = 'center'
  date.forced_width = beautiful.date_width
  statusbar_layout_left:add( wibox.container.margin(date, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin) )
  statusbar_layout_left:add( statusbar_items_separator )

  statusbar_layout_left:add( wibox.container.margin(taglist_widget, beautiful.statusbar_items_margin) )
  statusbar_layout_left:add( wibox.container.margin(statusbar_items_separator, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin/2) )

  statusbar_layout_left:add( wibox.container.margin(s.statusbar_current_layout_name, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin+2) )
  statusbar_layout_left:add( statusbar_items_separator )

  statusbar_layout_left:add(wibox.container.margin(tasklist_widget, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin))

  statusbar_layout:set_left(statusbar_layout_left)

  -- on main screen only, show the systray (it can't be shown on multiple screens)
  if s == screen.primary then
    statusbar_layout_right = wibox.layout.fixed.horizontal()
    s.statusbar_layout_right = statusbar_layout_right
    mysystray = wibox.widget.systray()
    mysystray:set_base_size(28)
    mysystray:fit({dpi = s.dpi })
    mysystray.forced_height = beautiful.statusbar_height

    statusbar_layout_right:add(wibox.container.margin(awful.widget.watch('/home/manu/bin/echo-temp', 5), beautiful.statusbar_items_margin, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin) )

    statusbar_layout_right:add(wibox.container.margin(awful.widget.watch('/home/manu/bin/echo-bat-cap', 20), beautiful.statusbar_items_margin, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin) )

    local power_profile_button = wibox.widget.textbox('loading…')
    awful.spawn.easy_async('/home/manu/bin/acpi_profile status', function(output)
        power_profile_button.text = output
    end)
    power_profile_button:buttons(awful.util.table.join(
      awful.button({ }, 1, function()
        power_profile_button.text = 'loading…'
        awful.spawn.easy_async('/home/manu/bin/acpi_profile toggle', function(output)
            power_profile_button.text = output
        end)
      end)
    ))
    statusbar_layout_right:add(wibox.container.margin(power_profile_button, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin) )

    local icons_folder = '/usr/share/icons/Papirus-Dark/32x32/symbolic/status/'

    local mic_button = wibox.widget.imagebox(icons_folder .. 'audio-volume-muted-symbolic.svg', true)
    mic_button.forced_width = 16
    mic_button.forced_height = 16
    -- this is a global function so that we can easily call it with awesome-client later
    update_mic_icon = function()
        awful.spawn.easy_async('/home/manu/bin/pactl-notif-utils mic-muted-state', function(output)
            mic_button.image = icons_folder .. 'audio-input-microphone-' .. (string.find(output, 'muted') and 'muted' or 'high') .. '-symbolic.svg'
        end)
    end
    update_mic_icon()
    mic_button:buttons(awful.util.table.join(
      awful.button({ }, 1, function()
        awful.spawn.with_shell("/home/manu/bin/mic-toggle")
      end),
      awful.button({ }, 3, function()
        awful.spawn.with_shell(
          "rofi -show rofi-sound -modi \"rofi-sound:rofi-sound-output-chooser\""
        )
      end)
    ))
    local mic_tooltip = awful.tooltip { }
    mic_tooltip:add_to_object(mic_button)
    mic_button:connect_signal('mouse::enter', function()
      awful.spawn.easy_async('/home/manu/bin/pactl-notif-utils mic-name', function(output)
          -- remove newlines
          mic_tooltip.text = string.gsub(output, '\n', '')
      end)
    end)
    statusbar_layout_right:add(wibox.container.margin(mic_button, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin_top) )

    local dnd_button = wibox.widget.imagebox(icons_folder .. 'notification-symbolic.svg', true)
    dnd_button.forced_width = 16
    dnd_button.forced_height = 16
    -- this is a global function so that we can easily call it with awesome-client later
    update_dnd_icon = function()
        awful.spawn.easy_async('dunstctl is-paused', function(output)
            dnd_button.image = icons_folder .. (string.find(output, 'false') and 'notification' or 'process-error') .. '-symbolic.svg'
        end)
    end
    update_dnd_icon()
    dnd_button:buttons(awful.util.table.join(
      awful.button({ }, 1, function()
        -- if i just span directly, the cursor transforms to a loading one and stays like that? using async to avoid that
        awful.spawn.easy_async('/home/manu/bin/dnd', function() end)
      end)
    ))
    statusbar_layout_right:add(wibox.container.margin(dnd_button, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin_top) )

    local displayswitch_button = wibox.widget.imagebox('/home/manu/.config/awesome/themes/leimi/video-joined-displays-symbolic.svg', true)
    displayswitch_button.forced_width = 16
    displayswitch_button.forced_height = 16
    displayswitch_button:buttons(awful.util.table.join(
        awful.button({ }, 1, function() awful.spawn.with_shell('xfce4-display-settings --minimal') end)
    ))
    statusbar_layout_right:add(wibox.container.margin(displayswitch_button, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin * 4, beautiful.statusbar_items_margin_top) )

    statusbar_layout_right:add(mysystray)
    s.systray = mysystray

    local logout_button = wibox.widget.imagebox('/home/manu/.config/awesome/themes/leimi/system-shutdown-symbolic.svg', true)
    logout_button.forced_width = 16
    logout_button.forced_height = 16
    logout_button:buttons(awful.util.table.join(
        awful.button({ }, 1, function() awful.spawn('xfce4-session-logout') end)
    ))
    statusbar_layout_right:add(wibox.container.margin(logout_button, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin, beautiful.statusbar_items_margin_top) )

    statusbar_layout:set_right(statusbar_layout_right)
  end

  statusbar_widget:set_widget(wibox.container.margin(statusbar_layout, beautiful.statusbar_margin_horizontal, beautiful.statusbar_margin_horizontal, beautiful.statusbar_margin_top, beautiful.statusbar_margin_bottom))
end)

screen.connect_signal("primary_changed", function(s)
  big_screen = screen.primary.geometry.width > 2500 and screen.primary.geometry.height > 1400
end)
