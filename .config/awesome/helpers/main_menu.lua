require("archmenu")
-- archmenu file generated via:
-- `xdg_menu --format awesome --root-menu /etc/xdg/menus/arch-applications.menu > ~/.config/awesome/archmenu.lua`
-- the archmenu file has a `xdgmenu` global variable

local main_menu = {}

function main_menu.create()
  local hotkeys_popup = require("awful.hotkeys_popup")
  table.insert(xdgmenu, { "Raccourcis clavier", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end })
  table.insert(xdgmenu, { "Terminal", terminal })
  table.insert(xdgmenu, { "Quitter", "xfce4-session-logout" })
  return awful.menu.new({ items = xdgmenu, theme = { height = 22, width = 200 } })
end

return main_menu
