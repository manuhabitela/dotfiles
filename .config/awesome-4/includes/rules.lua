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
      border_width = 1,
      screen = awful.screen.preferred,
      callback = awful.client.setslave,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen
    }
  },

  -- some clients are floating by default, others don't have borders - see variables declaration at top
  {
    rule_any = { class = floating_classes },
    properties = { floating = true }
  },
  {
    rule_any = { instance = floating_instances, name = noborders_instances },
    properties = { floating = true }
  },
  {
    rule_any = { instance = noborders_instances, name = noborders_instances },
    properties = { border_width = 0 }
  },

  {
    rule_any = { class = { "Sublime_text", "Subl" } },
    properties = { tag = screen.primary.tags[2] }
  },
  {
    rule_any = { class = { "git-cola", "git-cola" } },
    properties = { tag = screen.primary.tags[4] }
  },
  {
    rule_any = { class = { "Roxterm", terminal } },
    properties = { tag = screen.primary.tags[7] }
  },
  {
    rule_any = { class = { "Chromium-browser", "Chromium" } },
    properties = { tag = screen.primary.tags[big_screen and 2 or 3] }
  },
  {
    rule_any = { class = { "Google-chrome", "google-chrome" } },
    properties = { tag = screen.primary.tags[big_screen and 2 or 3] }
  }
}
