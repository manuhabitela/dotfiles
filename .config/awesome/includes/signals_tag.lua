awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.floating,
  awful.layout.suit.max,
  awful.layout.suit.tile.bottom
}

local tag_map = {
  tile = "tile",
  tilebottom = "tileb",
  max = "max",
  floating = "float"
}

local function update_statusbar_tag(t)
  if t.screen.statusbar_current_layout_name then
    local tag_name = awful.layout.getname()
    t.screen.statusbar_current_layout_name:set_text(tag_map[tag_name] or tag_name)
  end
end

tag.connect_signal("property::layout", function(t)
  for k, c in ipairs(t:clients()) do
    if awful.layout.getname() == "floating" then
      helpers.clients.show_titlebar_and_resize(c)
    else
      awful.titlebar.hide(c)
    end
  end
  update_statusbar_tag(t)
end)

tag.connect_signal("property::selected", function(t)
  update_statusbar_tag(t)
  helpers.wallpaper.update(awful.screen.focused())
end)
