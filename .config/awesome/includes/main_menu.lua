local xdg_menu = require("archmenu")

table.insert(xdgmenu, { "Terminal", terminal })
table.insert(xdgmenu, { "Quitter", "/home/manu/bin/lxde-logout" })
main_menu = awful.menu.new({ items = xdgmenu, theme = { height = 22, width = 200 } })

client.connect_signal("button::press", function(c)
  main_menu:hide()
end)

client.connect_signal("focus", function(c)
  main_menu:hide()
end)
