-- default mouse bindings that work everywhere
root.buttons(gears.table.join(
  awful.button({ }, 3, function() main_menu:toggle() end)
))
