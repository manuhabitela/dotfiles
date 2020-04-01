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
  {
    rule_any = { name = { "spotify-tui" }, class = { "Spotify" } },
    properties = { tag = screen.primary.tags[1] }
  },
  {
    rule_any = { class = { "Sublime_text", "Subl" } },
    properties = { tag = screen.primary.tags[2] }
  },
  {
    rule_any = { class = { "Google-chrome" } },
    properties = { tag = screen.primary.tags[big_screen and 2 or 3] }
  },
  {
    rule_any = { class = { "git-cola" } },
    properties = { tag = screen.primary.tags[4] }
  },
  {
    rule_any = { class = terminal_tag_classes },
    except_any = { name = terminal_app_names },
    properties = { tag = screen.primary.tags[7] }
  }
}
