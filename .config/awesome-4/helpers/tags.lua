local tags = {}
tags.focused_clients = { {}, {}, {}, {} }
tags.previous_tags = { }

-- move to a tag through the given callback (awful.tag.viewnext, viewonly, etc)
-- keeps info about which client is focused on each tag before each move
-- in order to be able to put the focus back on them when going back on the tag
function tags.gototag(callback)
  local current_screen = mouse.screen
  local from_tag = current_screen.selected_tag
  if client.focus then
    tags.focused_clients[current_screen][from_tag] = client.focus
  end
  callback()
  local new_tag = current_screen.selected_tag
  if tags.focused_clients[current_screen][new_tag] and awful.client.focus.filter(tags.focused_clients[current_screen][new_tag]) then
    client.focus = tags.focused_clients[current_screen][new_tag]
  else
    awful.client.focus.byidx( 1)
  end
end

function tags.toggletag(screen_number, tag_number, force)
  tag_number = tonumber(tag_number)
  local current_tag = tonumber(screen_number.selected_tag.name)
  if force ~=1 and current_tag == tag_number then
    local previous_tag_number = tags.previous_tags[screen_number]
    tags.gototag(function()
      screen_number.tags[previous_tag_number]:view_only()
    end)
  else
    tags.gototag(function()
      screen_number.tags[tag_number]:view_only()
    end)
  end
  tags.previous_tags[screen_number] = current_tag
end

return tags