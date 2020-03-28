-- not in use since awesome 4
local titlebar = {}

-- custom titlewidget:
-- * text aligned to left with small left-margin
-- * text becomes bold on focus
function titlebar.titlewidget(c)
  local ret = wibox.widget.textbox()
  local function update_title()
    ret:set_text(c.name and ("  "..c.name) or "")
  end
  local function update_font()
    ret:set_font(c == client.focus and beautiful.font_title_focus or beautiful.font_title)
  end
  c:connect_signal("property::name", update_title)
  c:connect_signal("focus", update_font)
  c:connect_signal("unfocus", update_font)
  update_title()
  update_font()
  return ret
end

return titlebar