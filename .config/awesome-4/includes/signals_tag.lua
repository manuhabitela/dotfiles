awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.spiral.dwindle,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.max,
  awful.layout.suit.floating
}

local tag_map = {
  tile = "tile",
  dwindle = "dwin",
  tilebottom = "tileb",
  max = "max",
  floating = "float"
}

local function update_statusbar_tag(t)
  if t.screen.statusbar_current_layout_name then
    t.screen.statusbar_current_layout_name:set_text(tag_map[awful.layout.getname()])
  end
end

tag.connect_signal("property::layout", function(t)
  for i, client_tag in ipairs(t:clients()) do
    helpers.clients.update_client_colors(client_tag)
  end
  update_statusbar_tag(t)
end)

tag.connect_signal("property::selected", update_statusbar_tag)
