tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
      awful.layout.suit.tile,
      awful.layout.suit.spiral.dwindle,
      awful.layout.suit.tile.bottom,
      awful.layout.suit.max,
      awful.layout.suit.floating
    })
end)
