-- client rules
awful.rules.rules = {
  -- all clients will match this rule.
  {
    rule = { },
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      keys = clientkeys,
      buttons = clientbuttons,
      size_hints_honor = false,
      border_width = 1
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
  { rule_any = { class = { "Sublime_text", "Subl" } }, properties = { tag = tags[main_screen][2] } },
  { rule_any = { class = { "git-cola", "git-cola" } }, properties = { tag = tags[main_screen][4] } },
  { rule_any = { class = { "Roxterm", terminal } }, properties = { tag = tags[main_screen][7] } },
  { rule_any = { class = { "Chromium-browser", "Chromium" } }, properties = { tag = tags[main_screen][big_screen and 2 or 3] } },
  { rule_any = { class = { "Google-chrome", "google-chrome" } }, properties = { tag = tags[main_screen][big_screen and 2 or 3] } }
}