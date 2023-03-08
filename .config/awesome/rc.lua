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
terminal = "roxterm"
winkey = "Mod4"
modkey = winkey
altkey = "Mod1"
ctrl = "Control"
sft = "Shift"
-- classes = xprop > WM_CLASS > second string
floating_classes = { "MPlayer", "pinentry", "Gimp", "Yad"}
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
main_menu = helpers.main_menu.create()
calendar_widget_cmd = terminal .. ' -g 65x9 -p Awesome -T calendar-widget -e \'bash -c "cal -3; read line"\''
rofi_cmd = string.format(
  "rofi -show {mode} -font '%s'"
  .. " -color-normal '%s,%s,%s,%s,%s'" -- bg, fg, bgalt, bg-focus, fg-focus
  .. " -color-window '%s,%s,%s'" -- bg, border, separator
  .. " -location 1 -width 100 -lines 15 -i -matching fuzzy"
  .. " -terminal " .. terminal
  .. " -theme-str '"
  ..   "* { highlight: none; } "
  ..   "inputbar { children:  [ entry, num-filtered-rows, textbox-num-sep, num-rows, case-indicator ]; }'",
  beautiful.font_rofi,
  beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_normal, beautiful.bg_focus, beautiful.fg_focus,
  beautiful.bg_normal, beautiful.bg_normal, beautiful.bg_normal
)
dofile('/home/manu/.config/awesome/includes/autostart.lua')
dofile('/home/manu/.config/awesome/includes/signals_tag.lua')
dofile('/home/manu/.config/awesome/includes/signals_screen.lua')
dofile('/home/manu/.config/awesome/includes/shortcuts_keyboard_client.lua')
dofile('/home/manu/.config/awesome/includes/shortcuts_keyboard_global.lua')
dofile('/home/manu/.config/awesome/includes/shortcuts_mouse_client.lua')
dofile('/home/manu/.config/awesome/includes/shortcuts_mouse_global.lua')
dofile('/home/manu/.config/awesome/includes/rules.lua')
dofile('/home/manu/.config/awesome/includes/signals_client.lua')
