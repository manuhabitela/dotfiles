tag.connect_signal("property::layout", function(t)
  for i, client_tag in ipairs(t:clients()) do
    helpers.clients.update_client_colors(client_tag)
  end
    statusbar_current_layout_name:set_text(awful.layout.getname())
end)

tag.connect_signal("property::selected", function(t)
  statusbar_current_layout_name:set_text(awful.layout.getname())
end)