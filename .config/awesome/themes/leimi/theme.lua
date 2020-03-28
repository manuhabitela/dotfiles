---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.wallpaper = "/home/manu/.config/awesome/themes/leimi/angers.png"

theme.icon_theme = "Faenza"

-- theme.font          = "Open Sans Semi-Bold 10"
theme.font          = "San Francisco Text Regular 10"
-- theme.font          = "Misc Tamsyn 10.5"
theme.font_xft      = "Terminus (TTF)-12"
theme.font_title    = "San Francisco Text Medium 10"
theme.font_dmenu    = theme.font_xft

theme.bg_normal     = "#001d24"
theme.fg_normal     = "#93a1a1"
theme.border_normal = theme.bg_normal

theme.bg_focus      = theme.bg_normal
theme.fg_focus      = "#b58900"
theme.border_focus  = theme.fg_focus
theme.font_title_focus = theme.font_title
theme.tasklist_font = theme.font_title

theme.bg_floating = theme.bg_focus
theme.fg_floating = "#859900"
theme.border_floating = theme.fg_floating

theme.bg_maximized = theme.bg_focus
theme.fg_maximized = "#6c71c4"
theme.border_maximized = theme.fg_maximized

theme.border_width = 0

theme.statusbar_height = 28
theme.statusbar_margin = 2
theme.statusbar_margin_horizontal = 2
theme.statusbar_margin_top = 2
theme.statusbar_margin_bottom = 2
theme.statusbar_items_margin = 6
theme.statusbar_border_width = 1
theme.statusbar_border_color = "#073642"
theme.statusbar_bg_color = theme.bg_normal
theme.statusbar_separator_color = "#073642"

theme.taglist_font = theme.font
theme.taglist_bg_focus = theme.bg_normal
theme.taglist_fg_focus = theme.fg_focus
theme.taglist_squares_sel   = "/usr/share/awesome/themes/default/taglist/squarew.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/default/taglist/squarew.png"

theme.tasklist_plain_task_name = false

theme.clock_font = theme.font

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"
theme.awesome_icon = "/usr/share/icons/Faenza/places/24/distributor-logo.png"
theme.menu_submenu_icon = "/usr/share/awesome/themes/zenburn/titlebar/maximized_focus_inactive.png"
theme.menu_height = 22
theme.menu_width  = 200

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
