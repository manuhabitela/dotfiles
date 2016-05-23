local awful = require("awful")
local tags = {}
tags.focused_clients = { {}, {}, {}, {} }
tags.previous_tags = { }

-- move to a tag through the given callback (awful.tag.viewnext, viewonly, etc)
-- keeps info about which client is focused on each tag before each move
-- in order to be able to put the focus back on them when going back on the tag
function tags.gototag(callback)
  local current_screen = mouse.screen
  local from_tag = awful.tag.selected(current_screen)
  if client.focus then
    tags.focused_clients[current_screen][from_tag] = client.focus
  end
  callback()
  local new_tag = awful.tag.selected(current_screen)
  if tags.focused_clients[current_screen][new_tag] and awful.client.focus.filter(tags.focused_clients[current_screen][new_tag]) then
    client.focus = tags.focused_clients[current_screen][new_tag]
  else
    awful.client.focus.byidx( 1)
  end
end

function tags.toggletag(screen_number, tag_number, force)
  tag_number = tonumber(tag_number)
  local current_tag = tonumber(awful.tag.selected(screen_number).name)
  if force ~=1 and current_tag == tag_number then
    local previous_tag_number = tags.previous_tags[screen_number]
    tags.gototag(function()
      awful.tag.viewonly(awful.tag.gettags(screen_number)[previous_tag_number])
    end)
  else
    tags.gototag(function()
      awful.tag.viewonly(awful.tag.gettags(screen_number)[tag_number])
    end)
  end
  tags.previous_tags[screen_number] = current_tag
end

return tags