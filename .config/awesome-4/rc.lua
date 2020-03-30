pcall(require, "luarocks.loader")
gears = require("gears")
awful = require("awful")
require("awful.autofocus")
common = require("awful.widget.common")
wibox = require("wibox")
beautiful = require("beautiful")

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
helpers.tasklist = require("helpers.tasklist")
helpers.tasklist_widget = require("helpers.tasklist_widget_copy")
helpers.string = require("helpers.string")

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

dofile('/home/manu/.config/awesome/includes/autostart.lua')
dofile('/home/manu/.config/awesome/includes/signals_tag.lua')
dofile('/home/manu/.config/awesome/includes/signals_screen.lua')
dofile('/home/manu/.config/awesome/includes/shortcuts_keyboard_client.lua')
dofile('/home/manu/.config/awesome/includes/shortcuts_keyboard_global.lua')
dofile('/home/manu/.config/awesome/includes/shortcuts_mouse_client.lua')
dofile('/home/manu/.config/awesome/includes/shortcuts_mouse_global.lua')
dofile('/home/manu/.config/awesome/includes/rules.lua')
dofile('/home/manu/.config/awesome/includes/signals_client.lua')
