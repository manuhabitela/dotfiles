---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.wallpaper = "/home/manu/Dropbox/Mes documents/Mes images/Walls/mhcy2u.jpg"

theme.icon_theme = "Faenza"

theme.font          = "Lucida Grande 9"
theme.font_xft      = "Lucida Grande-9"
theme.font_title    = "Lucida Grande 9"
theme.font_dmenu    = "Lucida Grande-12"

theme.bg_normal     = "#222222"
theme.fg_normal     = "#dddddd"
theme.border_normal = "#000000"

theme.bg_focus      = "#395899"
theme.fg_focus      = "#ffffff"
theme.border_focus  = theme.bg_focus
theme.font_title_focus = "Lucida Grande Bold 9"

theme.bg_floating = "#00B2A9"
theme.fg_floating = theme.fg_focus
theme.border_floating = theme.bg_floating

theme.bg_maximized = "#00740A"
theme.fg_maximized = theme.fg_focus
theme.border_maximized = theme.bg_maximized

theme.border_width = 0

theme.taglist_font = "Lucida Grande Bold 9"
theme.taglist_bg_focus = "#2F497F"
theme.taglist_squares_sel   = "/usr/share/awesome/themes/default/taglist/squarew.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/default/taglist/squarew.png"

theme.clock_font = "Lucida Grande 9"

theme.statusbar_height = 28
theme.statusbar_margin = 2
theme.statusbar_items_margin = 6
theme.statusbar_border_width = 1
theme.statusbar_border_color = "#333333"
theme.statusbar_bg_color = "#111111"
theme.statusbar_separator_color = "#888889"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"
theme.awesome_icon = "/usr/share/icons/Faenza/places/24/distributor-logo.png"
theme.menu_submenu_icon = "/usr/share/awesome/themes/zenburn/titlebar/maximized_focus_inactive.png"
theme.menu_height = 22
theme.menu_width  = 200

theme.titlebar_enabled = true
theme.titlebar_blacklist = { "roxterm", "exe", "plugin-container", "Plugin-container", "vlc" }
theme.titlebar_blacklist = { }
theme.titlebar_close_button_normal = "~/.config/awesome/themes/leimi/close.png"
theme.titlebar_close_button_focus  = "~/.config/awesome/themes/leimi/close.png"

theme.titlebar_minimize_button_normal_inactive = "~/.config/awesome/themes/leimi/minimize.png"
theme.titlebar_minimize_button_normal_active = "~/.config/awesome/themes/leimi/minimize.png"
theme.titlebar_minimize_button_focus_inactive  = "~/.config/awesome/themes/leimi/minimize.png"
theme.titlebar_minimize_button_focus_active  = "~/.config/awesome/themes/leimi/minimize.png"

theme.titlebar_maximized_button_normal_inactive = "~/.config/awesome/themes/leimi/maximize.png"
theme.titlebar_maximized_button_focus_inactive  = "~/.config/awesome/themes/leimi/maximize.png"
theme.titlebar_maximized_button_normal_active = "~/.config/awesome/themes/leimi/maximize.png"
theme.titlebar_maximized_button_focus_active  = "~/.config/awesome/themes/leimi/maximize.png"

theme.titlebar_floating_button_normal_inactive = "/usr/share/icons/Faenza-Darkest/actions/16/edit-copy.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/icons/Faenza-Darkest/actions/16/edit-copy.png"
theme.titlebar_floating_button_normal_active = "/usr/share/icons/Faenza-Darkest/actions/16/edit-copy.png"
theme.titlebar_floating_button_focus_active  = "/usr/share/icons/Faenza-Darkest/actions/16/edit-copy.png"

theme.layout_tile       = "/usr/share/awesome/themes/zenburn/layouts/tile.png"
theme.layout_tileleft   = "/usr/share/awesome/themes/zenburn/layouts/tileleft.png"
theme.layout_tilebottom = "/usr/share/awesome/themes/zenburn/layouts/tilebottom.png"
theme.layout_tiletop    = "/usr/share/awesome/themes/zenburn/layouts/tiletop.png"
theme.layout_fairv      = "/usr/share/awesome/themes/zenburn/layouts/fairv.png"
theme.layout_fairh      = "/usr/share/awesome/themes/zenburn/layouts/fairh.png"
theme.layout_spiral     = "/usr/share/awesome/themes/zenburn/layouts/spiral.png"
theme.layout_dwindle    = "/usr/share/awesome/themes/zenburn/layouts/dwindle.png"
theme.layout_max        = "/usr/share/awesome/themes/zenburn/layouts/max.png"
theme.layout_fullscreen = "/usr/share/awesome/themes/zenburn/layouts/fullscreen.png"
theme.layout_magnifier  = "/usr/share/awesome/themes/zenburn/layouts/magnifier.png"
theme.layout_floating   = "/usr/share/awesome/themes/zenburn/layouts/floating.png"

return theme