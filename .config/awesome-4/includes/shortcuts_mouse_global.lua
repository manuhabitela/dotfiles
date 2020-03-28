-- default mouse bindings that work everywhere
awful.mouse.append_global_mousebindings({
  awful.button({ }, 3, function() main_menu:toggle() end),
  awful.button({ }, 4, awful.tag.viewnext),
  awful.button({ }, 5, awful.tag.viewprev)
})

