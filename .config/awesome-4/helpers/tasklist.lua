-- I guess I should not need this thanks to
-- theme.tasklist_disable_icon but i can't get it to work…

local tasklist = {}

-- custom option to pass to the tasklist - show only app names
function tasklist.names_only_list(w, buttons, label, data, objects)
  w:reset()
  for i, o in ipairs(objects) do
    local cache = data[o]
    local l, tb, m, bgb
    if cache then
      tb = cache.tb
      m = cache.m
      bgb = cache.bgb
    else
      tb = wibox.widget.textbox()
      bgb = wibox.widget.background()
      m = wibox.layout.margin(tb, 4, 4, 1, 1)
      l = wibox.layout.fixed.horizontal()

      l:add(m)

      bgb:set_widget(l)

      bgb:buttons(common.create_buttons(buttons, o))

      data[o] = {
        tb = tb,
        bgb = bgb,
        m = m
      }
    end

    local text, bg, bg_image, icon = label(o)
    -- The text might be invalid, so use pcall
    if not pcall(tb.set_markup, tb, text) then
        tb:set_markup("<i>&lt;Invalid text&gt;</i>")
    end
    bgb:set_bg(bg)
    if type(bg_image) == "function" then
      bg_image = bg_image(tb,o,m,objects,i)
    end
    bgb:set_bgimage(bg_image)
    w:add(bgb)
  end
end

return tasklist