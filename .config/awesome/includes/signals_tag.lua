awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.floating,
  awful.layout.suit.max,
  awful.layout.suit.tile.bottom
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
    local tag_name = awful.layout.getname()
    t.screen.statusbar_current_layout_name:set_text(tag_map[tag_name] or tag_name)
  end
end

tag.connect_signal("property::layout", function(t)
  local toggle_titlebar = awful.layout.getname() == "floating" and awful.titlebar.show or awful.titlebar.hide
  for k, c in ipairs(t:clients()) do
    toggle_titlebar(c)
  end
  update_statusbar_tag(t)
end)

tag.connect_signal("property::selected", function(t)
  update_statusbar_tag(t)
  helpers.wallpaper.update(awful.screen.focused())
end)
