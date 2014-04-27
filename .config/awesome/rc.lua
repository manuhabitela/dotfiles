local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
local common = require("awful.widget.common")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local myhelpers = require("helpers")
local scratchdrop = require("scratchdrop")
-- homemade stuff
local leimi = require('leimi')


-- error handling
-- check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  myhelpers.notify({
    urgency = "critical",
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors
  })
end
-- handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    -- make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true
    myhelpers.notify({
      urgency = "critical",
      title = "Oops, an error happened!",
      text = err
    })
    in_error = false
  end)
end


-- config stuff
os.setlocale(os.getenv("LANG"))
beautiful.init("/home/manu/.config/awesome/themes/leimi/theme.lua")
terminal = "roxterm"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor
winkey = "Mod4"
modkey = winkey
local altkey = "Mod1"
local ctrl = "Control"
local sft = "Shift"
local titlebars_enabled = true
local titlebars_blacklist = { "guake", "exe", "plugin-container", terminal }
local floating_classes = { "MPlayer", "pinentry", "Gimp", "Guake"}
local floating_instances = {"exe", "plugin-container"}
local noborders_instances = {}
local main_screen = screen.count() > 1 and 2 or 1
-- menu config: using own fork of awesome-freedesktop for i18n https://github.com/Leimi/awesome-freedesktop/tree/feature-simple-localization
require('awesome-freedesktop.freedesktop.utils')
freedesktop.utils.terminal = terminal  -- default: "xterm"
freedesktop.utils.icon_theme = beautiful.icon_theme -- look inside /usr/share/icons/, default: nil (don't use icon theme)
freedesktop.utils.lang = "fr"
require('awesome-freedesktop.freedesktop.menu')
freedesktop.menu.categories = {
  accessories = "Accessoires",
  dev = "Développement",
  education = "Éducation",
  games = "Jeux",
  graphics = "Graphisme",
  web = "Internet",
  media = "Multimédia",
  office = "Bureautique",
  other = "Autre",
  settings = "Paramètres",
  system = "Système"
}


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


-- main_menu = awful.menu({ items = freedesktop.menu.new() })
main_menu = awful.menu({ items = {} })


-- statusbar config: we have a systray, a launcher, a taglist and a tasklist
statusbars = {}
taglists = {}
tasklists = {}
-- normal taglist mouse buttons
taglists.buttons = awful.util.table.join(
  awful.button({ }, 1, awful.tag.viewonly),
  awful.button({ modkey }, 1, awful.client.movetotag),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, awful.client.toggletag),
  awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)
-- normal tasklist mouse buttons
tasklists.buttons = awful.util.table.join(
  awful.button({ }, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      -- Without this, the following
      -- :isvisible() makes no sense
      c.minimized = false
      if not c:isvisible() then
        awful.tag.viewonly(c:tags()[1])
      end
      -- This will also un-minimize
      -- the client, if needed
      client.focus = c
      c:raise()
    end
  end),
  awful.button({ }, 3, function()
    if instance then
      instance:hide()
      instance = nil
    else
      instance = awful.menu.clients({
      theme = { width = 250 }
      })
    end
  end),
  awful.button({ }, 4, function()
    awful.client.focus.byidx(1)
    if client.focus then client.focus:raise() end
  end),
  awful.button({ }, 5, function()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
  end)
)
launcher = awful.widget.launcher({
  image = beautiful.awesome_icon,
  menu = main_menu
})

for s = 1, screen.count() do
  statusbars[s] = awful.wibox({ position = "bottom", align = "right", screen = s, height = 1, width = 600 })
  taglists[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglists.buttons)
  -- we show all apps in the tasklist with icons only
  tasklists[s] = awful.widget.tasklist(
    s,
    awful.widget.tasklist.filter.alltags,
    tasklists.buttons,
    nil,
    leimi.icons_only_list,
    wibox.layout.fixed.horizontal()
  )

  local statusbar_layout_left = wibox.layout.fixed.horizontal()
  local statusbar_layout_right = wibox.layout.fixed.horizontal()
  statusbar_layout_left:add(tasklists[s])
  if s == main_screen then
    local mysystray = wibox.widget.systray()
    mysystray:set_base_size(24)
    mysystray:fit()
    statusbar_layout_right:add( mysystray ) -- systray not working with a margin layout? putting margins on siblings widgets instead
  end
  statusbar_layout_right:add( wibox.layout.margin(taglists[s], 10) )
  local clock = awful.widget.textclock("%H:%M")
  clock:set_font(beautiful.taglist_font)
  statusbar_layout_right:add( wibox.layout.margin(clock, 8) )
  statusbar_layout_right:add( wibox.layout.margin(launcher, 8) )
  local statusbar_layout = wibox.layout.align.horizontal()
  statusbar_layout:set_left(statusbar_layout_left)
  statusbar_layout:set_right(statusbar_layout_right)
  statusbars[s]:set_widget(statusbar_layout)
  -- the statusbar is "floating": its height is 1px high when "hidden"
  -- we can then put cursor at bottom of screen to trigger mouse::enter signal and show it above clients
  leimi.show_floating_wibox(statusbars[s])
  statusbars[s]:connect_signal('mouse::enter', function()
        leimi.show_floating_wibox(statusbars[s])
  end)
end


-- global keyboard shortcuts - work all the time everywhere
globalkeys = awful.util.table.join(
  -- go to next or prev tag with (shift+)tab
  awful.key({ modkey,           }, "Tab",     function()
    leimi.gototag(awful.tag.viewnext)
    leimi.show_floating_wibox(statusbars[mouse.screen])
  end),
  awful.key({ modkey, sft       }, "Tab",     function()
    leimi.gototag(awful.tag.viewprev)
    leimi.show_floating_wibox(statusbars[mouse.screen])
  end),

  -- almost normal alt-tab behavior with rofi https://github.com/DaveDavenport/rofi
  awful.key({ altkey,           }, "Tab",     function()
    awful.util.spawn_with_shell(string.format(
      'rofi -now -font "%s" -fg "%s" -bg "%s" -hlfg "%s" -hlbg "%s" -o 95 -width 600',
      beautiful.font_xft, beautiful.fg_normal, beautiful.bg_normal, beautiful.fg_focus, beautiful.bg_focus
    ))
  end),

  -- move current client to next (or prev cause it's cycling) screen - ² key is right next to the 1
  awful.key({ modkey            }, "²",     function()
    awful.client.movetoscreen(client.focus)
  end),

  -- focus next or prev client - works accross all screens
  awful.key({ modkey,           }, "k",       function()
    leimi.client_focus_global_byidx(-1)
    if client.focus then client.focus:raise() end
  end),
  awful.key({ modkey,           }, "l",       function()
    leimi.client_focus_global_byidx(1)
    if client.focus then client.focus:raise() end
  end),

  -- shift + jklm to resize windows
  awful.key({ modkey, sft       }, "j",       function() awful.tag.incmwfact(-0.05) end),
  awful.key({ modkey, sft       }, "k",       function() awful.client.incwfact(-0.1) end),
  awful.key({ modkey, sft       }, "l",       function() awful.client.incwfact( 0.1) end),
  awful.key({ modkey, sft       }, "m",       function() awful.tag.incmwfact( 0.05) end),

  -- add or remove focused client to the master side
  awful.key({ modkey,           }, "h",       function() awful.tag.incnmaster( 1) end),
  awful.key({ modkey, sft       }, "h",       function() awful.tag.incnmaster(-1) end),

  -- cycle through existing layouts
  awful.key({ modkey            }, "Return",       function() awful.layout.inc(layouts, 1) end),

  -- cycle all clients (move them)
  awful.key({ modkey            }, "c",       function() awful.client.cycle(true) end),

  -- put current client as the master one
  awful.key({ modkey            }, "e",       function() awful.client.setmaster(client.focus) end),

  -- toggle the visibility of the statusbar
  awful.key({ modkey,           }, "v",     function()
    leimi.toggle_floating_wibox(statusbars[mouse.screen])
  end),

  -- run or raise applications
  awful.key({ modkey            }, "f",       function() leimi.ror("pcmanfm", "Pcmanfm") end),
  awful.key({ modkey            }, "s",       function() leimi.ror("subl", "Sublime_text") end),
  awful.key({ modkey            }, "w",       function() leimi.ror("chromium-browser", "Chromium-browser") end),
  awful.key({ modkey            }, "p",       function() leimi.ror("pidgin", "Pidgin") end),
  awful.key({ modkey            }, "g",       function() leimi.ror("git-cola", "Git-cola") end),

  -- dmenu with fuzzy matching through -z option https://aur.archlinux.org/packages/dmenu-xft-fuzzy/
  awful.key({ modkey            }, "space",   function()
    awful.util.spawn_with_shell(string.format(
      "dmenu_run -fn '%s' -nf '%s' -nb '%s' -sf '%s' -sb '%s' -b -z",
      beautiful.font_xft, beautiful.fg_normal, beautiful.bg_normal, beautiful.fg_focus, beautiful.bg_focus
    ))
  end),
  awful.key({ modkey            }, "r",   function()
    awful.util.spawn_with_shell(string.format(
      "dmenu_run -fn '%s' -nf '%s' -nb '%s' -sf '%s' -sb '%s' -b -z",
      beautiful.font_xft, beautiful.fg_normal, beautiful.bg_normal, beautiful.fg_focus, beautiful.bg_focus
    ))
  end),

  -- quake like terminal through https://github.com/copycat-killer/awesome-copycats/ scratchdrop
  awful.key({ altkey,           }, "space",   function () scratchdrop(terminal) end),
  awful.key({ modkey,           }, "t",   function () scratchdrop(terminal) end),

  awful.key({ modkey, ctrl      }, "r",       awesome.restart),
  awful.key({ modkey, ctrl, sft }, "q",       awesome.quit)
)

-- bind all key numbers to tags
for i = 1, 9 do
  globalkeys = awful.util.table.join(globalkeys,
    -- go to tag x on the current screen, focusing back the client that was last focused on the given tag
    awful.key({ modkey      }, "#" .. i + 9, function()
      leimi.gototag(function()
        awful.tag.viewonly(awful.tag.gettags(mouse.screen)[i])
      end)
    end),
    -- go to tag x on the current screen and move currently focused client on the given tag
    awful.key({ modkey, sft }, "#" .. i + 9, function()
      leimi.gototag(function()
        local tag = awful.tag.gettags(client.focus.screen)[i]
        leimi.focused_clients[client.focus.screen][tag] = client.focus
        awful.client.movetotag(tag)
        awful.tag.viewonly(tag)
      end)
    end)
  )
end

-- set all global keyboard shortcuts
root.keys(globalkeys)

-- default mouse bindings that work everywhere
root.buttons(awful.util.table.join(
  awful.button({ }, 3, function() main_menu:toggle() end),
  awful.button({ }, 4, awful.tag.viewnext),
  awful.button({ }, 5, awful.tag.viewprev)
))


-- client keyboard shortcuts
clientkeys = awful.util.table.join(
  awful.key({ modkey, sft       }, "q",      function(c) c:kill() end),
  awful.key({ altkey            }, "F4",     function(c) c:kill() end),
  awful.key({ modkey            }, "u",      awful.client.floating.toggle),
  awful.key({ modkey,           }, "n",      function(c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
  end),
  awful.key({ modkey,           }, "m", function(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c.maximized_vertical   = not c.maximized_vertical
  end)
)

-- mouse buttons that works on a client - redefine the global mouse bindings for client behavior
clientbuttons = awful.util.table.join(
  awful.button({ }, 1, function(c)
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
  -- some clients are floating by default, others don't have borders - see variables declaration at top
  {
    rule_any = { class = floating_classes },
    properties = { floating = true }
  },
  {
    rule_any = { instance = floating_instances },
    properties = { floating = true }
  },
  {
    rule_any = { instance = noborders_instances },
    properties = { border_width = 0 }
  },
  { rule = { class = "Sublime_text" }, properties = { tag = tags[main_screen][1] } },
  { rule = { class = "Chromium-browser" }, properties = { tag = tags[main_screen][2] } }
}


-- signal function to execute when a new client appears.
client.connect_signal("manage", function(c, startup)
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
    and not myhelpers.contains(c.instance, titlebars_blacklist)
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
      awful.titlebar.widget.minimizebutton(c),
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
-- be sure the menu and statusbar are hidden when we are a on client (focusing it or clicking on it)
client.connect_signal("focus", function(c)
  c.border_color = beautiful.border_focus
  main_menu:hide()
end)

client.connect_signal("button::press", function(c)
  main_menu:hide()
  leimi.hide_floating_wibox(statusbars[mouse.screen])
end)

client.connect_signal("unfocus", function(c)
  c.border_color = beautiful.border_normal
end)

client.connect_signal("mouse::enter", function(c)
  leimi.hide_floating_wibox(statusbars[mouse.screen])
end)


-- autostarting apps - awesome_boot loads every .desktop file in standard autostart folder
awful.util.spawn_with_shell("awesome_boot")
