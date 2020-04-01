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
helpers.tags = require("helpers.tags")
helpers.screen = require("helpers.screen")
helpers.clients = require("helpers.clients")
helpers.main_menu = require("helpers.main_menu")
helpers.string = require("helpers.string")
helpers.wallpaper = require("helpers.wallpaper")
helpers.tasklist_widget = require("helpers.tasklist_widget")
helpers.calendar_widget = require("helpers.calendar_widget")
helpers.calendar_popup = require("helpers.calendar_popup")

dofile('/home/manu/.config/awesome/includes/errors.lua')

beautiful.init("/home/manu/.config/awesome/themes/leimi/theme.lua")
terminal = "roxterm"
winkey = "Mod4"
modkey = winkey
altkey = "Mod1"
ctrl = "Control"
sft = "Shift"
-- classes = xprop > WM_CLASS > second string
floating_classes = { "MPlayer", "pinentry", "Gimp", "Yad"}
-- instances = xprop > WM_CLASS > first string
floating_instances = {"exe", "plugin-container", "shutter"}
-- apps = client.name (= app "title")
terminal_app_names = {"spotify-tui"}
-- the tag 7 is exclusively for the terminal
terminal_tag = "7"
terminal_tag_classes = { "Roxterm", "Roxterm-config" }
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
