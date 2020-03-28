pcall(require, "luarocks.loader")
gears = require("gears")
awful = require("awful")
require("awful.autofocus")
awful.rules = require("awful.rules")
ruled = require("ruled")
common = require("awful.widget.common")
wibox = require("wibox")
beautiful = require("beautiful")
naughty = require("naughty")

-- homemade stuff
helpers = {}
helpers.notifier = require("helpers.notifier")
helpers.launcher = require("helpers.launcher")
helpers.titlebar = require("helpers.titlebar")
helpers.tasklist = require("helpers.tasklist")
helpers.tags = require("helpers.tags")
helpers.clients = require("helpers.clients")
helpers.wallpaper = require("helpers.wallpaper")
helpers.main_menu = require("helpers.main_menu")

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
floating_instances = {"exe", "plugin-container", "shutter"}
noborders_instances = {}
withborders_instances = {}
main_screen = 1
secondary_screen = 2
big_screen = screen[main_screen].geometry.width > 2500 and screen[main_screen].geometry.height > 1400
main_menu = helpers.main_menu.create()

dofile('/home/manu/.config/awesome/includes/autostart.lua')
dofile('/home/manu/.config/awesome/includes/rules.lua')
dofile('/home/manu/.config/awesome/includes/shortcuts_keyboard_client.lua')
dofile('/home/manu/.config/awesome/includes/shortcuts_keyboard_global.lua')
dofile('/home/manu/.config/awesome/includes/shortcuts_mouse_client.lua')
dofile('/home/manu/.config/awesome/includes/shortcuts_mouse_global.lua')
dofile('/home/manu/.config/awesome/includes/signals_client.lua')
dofile('/home/manu/.config/awesome/includes/signals_screen.lua')
dofile('/home/manu/.config/awesome/includes/signals_tag.lua')
