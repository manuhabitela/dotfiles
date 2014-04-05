local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local scratchdrop = require("scratchdrop")
local myhelpers = require("helpers")
-- homemade stuff - usually slightly modified existing functions in awesome
local leimi = require('leimi')
require("debian.menu")

-- error handling
-- check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors
  })
end
-- handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    -- make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true
    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = err
    })
    in_error = false
  end)
end

-- global variable definitions
os.setlocale(os.getenv("LANG"))
beautiful.init("/home/manu/.config/awesome/themes/leimi/theme.lua")
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor
winkey = "Mod4"
modkey = winkey
local altkey = "Alt"
local panel = "xfce4-panel"
local titlebars_enabled = true
local titlebars_blacklist = { classes = { }, instances = { "guake", "exe", "plugin-container" } }

-- layouts: simple tiles and fullscreen layout are enough
local layouts =
{
  awful.layout.suit.tile,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.max
}

-- wallpaper
if beautiful.wallpaper then
  for s = 1, screen.count() do
    gears.wallpaper.maximized(beautiful.wallpaper, s, true)
  end
end

-- each screen has its own set of 6 tags
tags = {}
for s = 1, screen.count() do
  tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6 }, s, layouts[1])
end

-- menu accessible through keybinding or right click on desktop
myawesomemenu = {
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  { "quit", awesome.quit }
}
mymainmenu = awful.menu({
  items = {
    { "awesome", myawesomemenu, beautiful.awesome_icon },
    { "Debian", debian.menu.Debian_menu.Debian },
    { "open terminal", terminal }
  }
})

-- screen padding - give 1px free at bottom to let xfce4-panel show up on mouse-enter
for s = 1, screen.count() do
  awful.screen.padding( screen[s], { bottom = 1 } )
end

-- keyboard shortcuts that work all the time everywhere
globalkeys = awful.util.table.join(
  awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
  awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
  awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

  awful.key({ modkey,           }, "j", function ()
    awful.client.focus.byidx( 1)
    if client.focus then client.focus:raise() end
  end),
  awful.key({ modkey,           }, "k", function ()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
  end),
  awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

  -- Layout manipulation
  awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
  awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
  awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
  awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
  awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),

  -- Standard program
  awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
  awful.key({ modkey, "Control" }, "r", awesome.restart),
  awful.key({ modkey, "Shift"   }, "q", awesome.quit),

  awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
  awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
  awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
  awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
  awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
  awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
  awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
  awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

  awful.key({ modkey, "Control" }, "n", awful.client.restore),

  -- Prompt
  awful.key({ modkey },            "r",     function () awful.util.spawn_with_shell("dmenu_run -fn 'Droid Sans-10' -b") end),
  awful.key({ },            "F1",     function() scratchdrop("guake", "bottom") end)
)

-- bind all key numbers to tags
focused_clients = {}
for i = 1, 9 do
  globalkeys = awful.util.table.join(globalkeys,
    -- go to tag x on the current screen, focusing back the client that was last focused on the given tag
    awful.key({ modkey }, "#" .. i + 9, function ()
      local screen = mouse.screen
      local from_tag = awful.tag.selected(screen)
      local to_tag = awful.tag.gettags(screen)[i]
      if client.focus then
        focused_clients[from_tag] = client.focus
      end
      if to_tag then
        awful.tag.viewonly(to_tag)
        if focused_clients[to_tag] and awful.client.focus.filter(focused_clients[to_tag]) then
          client.focus = focused_clients[to_tag]
        -- important ~hack because of xfce4-panel:
        -- if it's the first time we go on the tag, by default it always focuses xfce4-panel (don't know why)
        -- I don't want this behavior so I focus the next client after xfce
        else
          awful.client.focus.byidx( 1)
        end
      end
    end),
    -- go to tag x on the current screen and move currently focused client on the given tag
    awful.key({ modkey, "Shift" }, "#" .. i + 9, function ()
      if client.focus then
        local current_client = client.focus
        local tag = awful.tag.gettags(client.focus.screen)[i]
        if tag then
          awful.client.movetotag(tag)
          awful.tag.viewonly(tag)
          client.focus = current_client
        end
      end
    end)
  )
end

-- set all global keyboard shortcuts
root.keys(globalkeys)

-- keyboard shortcuts that work on a client
clientkeys = awful.util.table.join(
  awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
  awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill() end),
  awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
  awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
  awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
  awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
  awful.key({ modkey,           }, "n", function (c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
  end),
  awful.key({ modkey,           }, "m", function (c)
    c.maximized_horizontal = not c.maximized_horizontal
    c.maximized_vertical   = not c.maximized_vertical
  end)
)

-- default mouse bindings that work everywhere
root.buttons(awful.util.table.join(
  awful.button({ }, 3, function () mymainmenu:toggle() end),
  awful.button({ }, 4, awful.tag.viewnext),
  awful.button({ }, 5, awful.tag.viewprev)
))

-- mouse buttons that works on a client - redefine the global mouse bindings for client behavior
clientbuttons = awful.util.table.join(
  awful.button({ }, 1, function (c)
    if awful.client.focus.filter(c) then client.focus = c end
    c:raise()
  end),
  awful.button({ modkey }, 1, awful.mouse.client.move),
  awful.button({ modkey }, 3, awful.mouse.client.resize)
)

-- client rules
awful.rules.rules = {
  -- all clients will match this rule.
  {
    rule = { },
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      keys = clientkeys,
      buttons = clientbuttons
    }
  },
  -- these clients are floating by default
  {
    rule_any = { class = { "MPlayer", "pinentry", "Gimp"} },
    properties = { floating = true }
  },
  {
    rule_any = { instance = {"exe", "plugin-container"} },
    properties = { floating = true }
  }
}

-- signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
  -- enable sloppy focus (focus windows when mouse comes over them)
  -- c:connect_signal("mouse::enter", function(c)
  --     if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
  --         and awful.client.focus.filter(c) then
  --         client.focus = c
  --     end
  -- end)

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

  -- titlebar - for some clients we do not want it (their class or instance name is in a blacklist)
  if titlebars_enabled
    and not myhelpers.contains(c.instance, titlebars_blacklist.instances)
    and not myhelpers.contains(c.class, titlebars_blacklist.classes)
    and (c.type == "normal" or c.type == "dialog") then
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
    left_layout:add(leimi.titlewidget(c))
    left_layout:buttons(mouse_buttons)

    -- clickable buttons to minimize, maximize and close client on the right
    local right_layout = wibox.layout.fixed.horizontal()
    local title_buttons = {
      leimi.minimizebutton(c),
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
  end
end)

-- change client's border on focus change
client.connect_signal("focus", function(c)
  if c.name ~= panel then c.border_color = beautiful.border_focus end
end)
client.connect_signal("unfocus", function(c)
  if c.name ~= panel then c.border_color = beautiful.border_normal end
end)

-- show/hide xfce panel on mouse enter/leave without focusing it
client.connect_signal("mouse::enter", function(c)
  if c.name == panel then c:raise() end
end)
client.connect_signal("mouse::leave", function(c)
  if c.name == panel then c:lower() end
end)

-- autostarting apps - awesome_boot loads every .desktop file in standard autostart folder
awful.util.spawn_with_shell("awesome_boot")