---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.wallpaper = "/home/manu/.config/awesome/themes/leimi/angers-fhd.png"
theme.wallpaper_blur = "/home/manu/.config/awesome/themes/leimi/angers-fhd-blur.png"

theme.fonts = { default = "San Francisco Display Semi-Bold 10" }
theme.fonts.statusbar = theme.fonts.default
theme.fonts.titlebar = theme.fonts.default
theme.fonts.big = "San Francisco Display Semi-Bold 25"
theme.fonts.monospace = "Terminus (TTF) 12"

theme.colors = {
  blue_dark = "#073642",
  blue_very_dark = "#001d24",
  blue_very_light = "#93a1a1",
  orange = "#b58900",
  orange_light = "#e6ac00",
  white = "#eeeeee",
  gray = "#aaaaaa"
}

theme.font = theme.fonts.default
theme.bg_normal = theme.colors.blue_very_dark
theme.fg_normal = theme.colors.blue_very_light
theme.border_normal = theme.bg_normal
theme.border_width = 3
theme.useless_gap = 2.5
theme.gap_single_client = false

theme.bg_focus = theme.bg_normal
theme.fg_focus = theme.colors.orange
theme.border_focus = theme.colors.orange_light

theme.font_rofi = theme.fonts.big

theme.statusbar_font = theme.fonts.statusbar
theme.statusbar_bg_color = theme.colors.blue_very_dark
theme.statusbar_border_color = theme.colors.blue_dark
theme.statusbar_border_width = 1
theme.statusbar_separator_color = theme.colors.blue_dark
theme.statusbar_height = 28
theme.statusbar_margin = 2
theme.statusbar_margin_horizontal = 2
theme.statusbar_margin_top = 2
theme.statusbar_margin_bottom = 2
theme.statusbar_items_margin = 6
theme.statusbar_current_layout_width = 29

theme.systray_hints_font = theme.fonts.default
theme.systray_hints_bg = theme.colors.orange
theme.systray_hints_fg = theme.colors.blue_dark
theme.systray_hints_border = theme.colors.blue_dark

theme.menu_submenu_icon = "/usr/share/awesome/themes/zenburn/titlebar/maximized_focus_inactive.png"

theme.clock_width = 38
theme.date_width = 84

theme.taglist_bg_focus = theme.bg_normal
theme.taglist_fg_focus = theme.fg_focus
theme.taglist_font = theme.fonts.statusbar
theme.taglist_squares_sel = "/usr/share/awesome/themes/default/taglist/squarew.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/default/taglist/squarew.png"

theme.tasklist_font = theme.fonts.statusbar
theme.tasklist_plain_task_name = false

theme.titlebar_size = 24
theme.titlebar_fg = theme.colors.gray
theme.titlebar_fg_focus = theme.colors.white
theme.titlebar_font = theme.fonts.titlebar
theme.titlebar_close_button = "~/.config/awesome/themes/leimi/close.png"
theme.titlebar_close_button_normal_inactive = theme.titlebar_close_button
theme.titlebar_close_button_normal_active = theme.titlebar_close_button
theme.titlebar_close_button_focus_inactive = theme.titlebar_close_button
theme.titlebar_close_button_focus_active = theme.titlebar_close_button
theme.titlebar_minimize_button = "~/.config/awesome/themes/leimi/minimize.png"
theme.titlebar_minimize_button_normal_inactive = theme.titlebar_minimize_button
theme.titlebar_minimize_button_normal_active = theme.titlebar_minimize_button
theme.titlebar_minimize_button_focus_inactive  = theme.titlebar_minimize_button
theme.titlebar_minimize_button_focus_active  = theme.titlebar_minimize_button
theme.titlebar_maximized_button = "~/.config/awesome/themes/leimi/maximize.png"
theme.titlebar_maximized_button_normal_inactive = theme.titlebar_maximized_button
theme.titlebar_maximized_button_focus_inactive  = theme.titlebar_maximized_button
theme.titlebar_maximized_button_normal_active = theme.titlebar_maximized_button
theme.titlebar_maximized_button_focus_active  = theme.titlebar_maximized_button

return theme
