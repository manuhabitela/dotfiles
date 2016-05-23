gears = require("gears")
awful = require("awful")
awful.rules = require("awful.rules")
common = require("awful.widget.common")
awful.autofocus = require("awful.autofocus")
awful.remote = require("awful.remote")
wibox = require("wibox")
beautiful = require("beautiful")

-- homemade stuff
helpers = {}
helpers.notifier = require("helpers.notifier")
helpers.launcher = require("helpers.launcher")
helpers.titlebar = require("helpers.titlebar")
helpers.tasklist = require("helpers.tasklist")
helpers.tags = require("helpers.tags")
helpers.clients = require("helpers.clients")

dofile('/home/manu/.config/awesome/includes/errors.lua')

-- config stuff
beautiful.init("/home/manu/.config/awesome/themes/leimi/theme.lua")
terminal = "roxterm"
winkey = "Mod4"
modkey = winkey
altkey = "Mod1"
ctrl = "Control"
sft = "Shift"
floating_classes = { "MPlayer", "pinentry", "Gimp", "Yad"}
floating_instances = {"exe", "plugin-container"}
noborders_instances = {}
withborders_instances = {}
main_screen = screen.count() > 1 and 2 or 1
secondary_screen = 1
big_screen = screen[main_screen].geometry.width > 2500 and screen[main_screen].geometry.height > 1400

dofile('/home/manu/Dropbox/dotfiles/not-synced/awesome.lua')
dofile('/home/manu/.config/awesome/includes/wallpaper.lua')
dofile('/home/manu/.config/awesome/includes/main_menu.lua')
dofile('/home/manu/.config/awesome/includes/layouts.lua')
dofile('/home/manu/.config/awesome/includes/tags.lua')
dofile('/home/manu/.config/awesome/includes/statusbar.lua')
dofile('/home/manu/.config/awesome/includes/shortcuts_keyboard_global.lua')
dofile('/home/manu/.config/awesome/includes/shortcuts_keyboard_client.lua')
dofile('/home/manu/.config/awesome/includes/shortcuts_mouse_global.lua')
dofile('/home/manu/.config/awesome/includes/shortcuts_mouse_client.lua')
dofile('/home/manu/.config/awesome/includes/client_rules.lua')
dofile('/home/manu/.config/awesome/includes/client_signals.lua')
dofile('/home/manu/.config/awesome/includes/tag_signals.lua')
dofile('/home/manu/.config/awesome/includes/autostart.lua')
