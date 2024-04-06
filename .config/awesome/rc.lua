pcall(require, "luarocks.loader")
gears = require("gears")
awful = require("awful")
require("awful.remote")
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
helpers.date = require("helpers.date")
helpers.wallpaper = require("helpers.wallpaper")
helpers.tasklist_widget = require("helpers.tasklist_widget")

dofile('/home/manu/.config/awesome/includes/errors.lua')

beautiful.init("/home/manu/.config/awesome/themes/leimi/theme.lua")
-- require('nice')
terminal = "roxterm"
winkey = "Mod4"
modkey = winkey
altkey = "Mod1"
ctrl = "Control"
sft = "Shift"
-- classes = xprop > WM_CLASS > second string
floating_classes = { "MPlayer", "pinentry", "Gimp", "Yad", "ThinkFan UI", "Inkscape", "vysor"}
-- instances = xprop > WM_CLASS > first string
floating_instances = {"exe", "plugin-container", "shutter", "pavucontrol"}
-- apps = client.name (= app "title")
terminal_app_names = {"spotify-tui", "calendar-widget", "pcmanfm-term", "Roxterm-temp"}
-- the tag 7 is exclusively for the terminal
terminal_tag = "7"
terminal_tag_classes = { "Roxterm", "Roxterm-config", "kitty" }
browser_classes = { "Google-chrome", "firefox" }
code_editor_classes = { "Sublime_text", "Subl", "Code" }
other_screen_classes = { "Slack", "discord", "Spotify" }
main_screen = screen.primary
big_screen = helpers.screen.is_big(main_screen)
other_screen = nil
if big_screen and screen:count() == 2 then
  other_screen = screen[1] == main_screen and screen[2] or screen[1]
end
main_menu = helpers.main_menu.create()
calendar_widget_cmd = terminal .. ' -g 65x15 -p Awesome -T calendar-widget -e \'bash -c "/home/manu/bin/bashcalendar; read line"\''
rofi_cmd = "rofi -show combi"
  .. " -combi-modes \"window,run,ssh,clipboard:greenclip print,power:~/.config/rofi/power-menu \""
  .. " -display-combi \"!w!r!s!c!p\""
  .. " -modi combi,emoji,calc,translate,file-browser-extended"
dofile('/home/manu/.config/awesome/includes/autostart.lua')
dofile('/home/manu/.config/awesome/includes/signals_tag.lua')
dofile('/home/manu/.config/awesome/includes/signals_screen.lua')
systray_hints = require("systray_hints")
dofile('/home/manu/.config/awesome/includes/shortcuts_keyboard_client.lua')
dofile('/home/manu/.config/awesome/includes/shortcuts_keyboard_global.lua')
dofile('/home/manu/.config/awesome/includes/shortcuts_mouse_client.lua')
dofile('/home/manu/.config/awesome/includes/shortcuts_mouse_global.lua')
dofile('/home/manu/.config/awesome/includes/rules.lua')
dofile('/home/manu/.config/awesome/includes/signals_client.lua')
