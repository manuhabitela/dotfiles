tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
      awful.layout.suit.tile,
      awful.layout.suit.spiral.dwindle,
      awful.layout.suit.tile.bottom,
      awful.layout.suit.max,
      awful.layout.suit.floating
    })
end)

local function update_statusbar_tag(t)
  if t.screen.statusbar_current_layout_name then
    t.screen.statusbar_current_layout_name:set_text(awful.layout.getname())
  end
end

tag.connect_signal("property::layout", function(t)
  for i, client_tag in ipairs(t:clients()) do
    helpers.clients.update_client_colors(client_tag)
  end
  update_statusbar_tag(t)
end)

tag.connect_signal("property::selected", update_statusbar_tag)
