local tags = {}
local prev_tags = {}

function tags.toggle_tag(s, i)
  local s = awful.screen.focused()
  local current_tag = s.selected_tag
  local destination_tag = s.tags[i]
  if current_tag ~= destination_tag then
    prev_tags[s] = current_tag
    destination_tag:view_only()
  elseif prev_tags[s] then
    prev_tags[s]:view_only()
    prev_tags[s] = current_tag
  end
end

return tags