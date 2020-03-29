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
helpers.screen = require("helpers.screen")
helpers.clients = require("helpers.clients")
helpers.main_menu = require("helpers.main_menu")

dofile('/home/manu/.config/awesome/includes/errors.lua')

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
main_screen = screen.primary
big_screen = helpers.screen.is_big(main_screen)
main_menu = helpers.main_menu.create()

-- i guess the default_layouts signal should work anywhere in the code
-- but it seems it actually must be at the beginning of the rc.lua file to work…
-- so, putting signals_tag before others
dofile('/home/manu/.config/awesome/includes/signals_tag.lua')
dofile('/home/manu/.config/awesome/includes/autostart.lua')
dofile('/home/manu/.config/awesome/includes/rules.lua')
dofile('/home/manu/.config/awesome/includes/shortcuts_keyboard_client.lua')
dofile('/home/manu/.config/awesome/includes/shortcuts_keyboard_global.lua')
dofile('/home/manu/.config/awesome/includes/shortcuts_mouse_client.lua')
dofile('/home/manu/.config/awesome/includes/shortcuts_mouse_global.lua')
dofile('/home/manu/.config/awesome/includes/signals_client.lua')
dofile('/home/manu/.config/awesome/includes/signals_screen.lua')
