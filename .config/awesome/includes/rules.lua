-- client rules
awful.rules.rules = {
  -- all clients will match this rule.
  {
    rule = { },
    properties = {
      keys = clientkeys,
      buttons = clientbuttons,
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      size_hints_honor = false,
      screen = awful.screen.preferred,
      callback = awful.client.setslave,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen
    }
  },

  -- note: I might not have understood how the "rule" keyword works, as it's not
  -- working when I use it... so using rule_any all the time, even for really specific rules

  {
    rule_any = { class = floating_classes, instance = floating_instances },
    properties = { floating = true }
  },
  {
    rule_any = { name = { "calendar-widget" } },
    properties = {
      placement = awful.placement.bottom_left,
      border_width = 0,
      floating = true,
      ontop = true,
      sticky = true,
    }
  },

  -- note: we have other kind of home-made rules directly in the client signal
  -- the idea is to have a default opening tag for some apps, but only for the first time we
  -- open them, and i didn't find after 5 minutes search if we could do that with the rules table
}
