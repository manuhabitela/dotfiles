-- Manu's note: taken from https://github.com/ryanthomas-org/systray_hints
-- and very dirty changed to match my spacings/wiboxes/etc as I didn't get to make it work properly
-- by passing correctly options

-- S Y S T R A Y   H I N T S
-- rts/oarion7 - ryanthomas.org
-- Control the awesomewm systray from the keyboard using vimium-like
-- number hints. Developed and tested on awesome v4.3.

local awful = require("awful")
local gears = require("gears")
local b     = require("beautiful")
local wibox = require("wibox")
local s
local gdebug = require("gears.debug")

awful.screen.connect_for_each_screen(function(screen)
	if s == screen.primary then s = screen end
end)
if s == nil then return nil end

local tooltip_y = s.geometry.height - 42
local systray_y = s.geometry.height - 20
local systray_icon_width = 22

local systray_hints = {

    font              = b.systray_hints_font or b.taglist_font or b.font,
    bgcolor           = b.systray_hints_bg or b.taglist_bg_occupied or "#55465a",
    highlight         = b.systray_hints_bg_highlight or "#aa53aa",
    highlight_alt     = b.systray_hints_bg_highlight_alt or "#426f5a",
    color             = b.systray_hints_fg or b.taglist_fg_occupied or "#fdf6e3",
    bordercolor       = b.systray_hints_border or "#fdf6e333",
    spacing           = 5,
    mouse_buttons     = { "j", "k", "m" },
    default_button    = 3,
    popup             = popup,
    systray           = s.systray,
    wibox             = s.statusbar_widget, --wibox in which to locate the system tray
    run               = run,
}

local total
local was_hidden
local icon_width
local icons_x
local icons_y

local function delay(time, cmd)
    gears.timer( {  timeout = time, autostart = true, single_shot = true,
        callback = function () cmd () end, } )
end

local function execute(choice, mouse_button)

    local saved
    local factor
    local target

    saved = mouse.coords({x = x, y = y})
    if choice == 1 then factor = 0 else factor = choice - 1 end
    target = icons_x + ( icon_width * factor )
    mouse.coords { x = target , y = systray_y }

    if mouse_button ~= 2 then
        root.fake_input("button_press" , tostring(mouse_button))
        root.fake_input("button_release", tostring(mouse_button))
        delay(0.05, function () mouse.coords({x = saved.x, y = saved.y}, true) end)
    end

    if systray_hints.popup then systray_hints.popup.visible = false end

end

local function highlight_multidigits(total)
    local color
    for i = 9, total do
        color = systray_hints.highlight_alt
        if i == 9 then
            i = 1
            color = systray_hints.highlight
        end
        systray_hints.popup.widget:get_children()[1]:get_children()[i].widget:set_bg(color)
    end
end

local function get_key_input(total)

    local grabber
    local mouse_button
    local function conc(n) return tonumber( 1 .. n ) end
    mouse_button = systray_hints.default_button
    grabber = awful.keygrabber {
        mask_modkeys = true,
        autostart = true,
        keypressed_callback  = function(self, mod, key, cmd)
            if key == '1' and total > 9 then
                if systray_hints.popup then
                    highlight_multidigits(total)
                end
                grabber.keypressed_callback  = function(self, mod, key, cmd)
                        if key == "Return" then
                            execute(1, mouse_button)
                            grabber:stop()
                        elseif not key:match("%D") and conc(key) <= total then
                            execute(conc(key), mouse_button)
                            grabber:stop()
                        else
                            grabber:stop()
                            if was_hidden then systray_hints.systray.visible = false end
                            if systray_hints.popup then systray_hints.popup.visible = false end
                        end
                end
            elseif key == systray_hints.mouse_buttons[1] then mouse_button = 1
            elseif key == systray_hints.mouse_buttons[2] then mouse_button = 2
            elseif key == systray_hints.mouse_buttons[3] then mouse_button = 3
            elseif not key:match("%D") and tonumber(key) <= total then
                execute(tonumber(key), mouse_button)
                grabber:stop()
            else
                grabber:stop()
                if was_hidden then systray_hints.systray.visible = false end
                if systray_hints.popup then systray_hints.popup.visible = false end
            end
        end,
    }
end

local function show_popup(x, y, w, h)

    local hints = {}
    local hint_width

    local x = math.floor(x)
    local y = math.floor(y)

    total = math.floor( ( w - ( w % h ) ) / h + 1 )
    icon_width = systray_icon_width

    icons_x = math.floor( x + icon_width / 2)
    icons_y = math.floor( y + icon_width / 2)

    hint_width = icon_width - ( systray_hints.spacing * 2 )

    --Decide whether hints should display above or below systray icons.
    if y >= 100 then y = y - hint_width else y = y + hint_width end

    --Hide if already displayed
    if systray_hints.popup then systray_hints.popup.visible = false end

    local widget_shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 0)
    end

    for i = 1, total do

        local text
        local placement = {}
        local background = {}
        local margins = {}

        text        = wibox.widget.textbox(tostring(i))
        text.font   = systray_hints.font
        text.markup = '<span color="' .. systray_hints.color .. '">' ..
                      i .. '</span>'

        table.insert(placement, text)

        placement.widget = wibox.container.place
        table.insert(background, placement)

        background.widget             = wibox.container.background
        background.bg                 = systray_hints.bgcolor
        background.forced_width       = hint_width
        background.shape              = widget_shape
        background.shape_border_width = 0
        background.shape_border_color = systray_hints.bordercolor

        table.insert(margins, background)

        margins.widget = wibox.container.margin
        margins.right  = systray_hints.spacing
        margins.left  = systray_hints.spacing
        table.insert(hints, margins)
    end

    hints.layout = wibox.layout.fixed.horizontal
    systray_hints.popup = awful.popup {
        widget = {
            screen = s,
            hints,
            layout = wibox.layout.fixed.horizontal,
        },
        x = x,
        y = tooltip_y,
        visible = true,
        ontop = true,
        bg = "#00000000",
   }

end

local function get_geometry(hi)
      local g = gears.matrix.transform_rectangle
      return g(hi:get_matrix_to_device(), 0, 0, hi:get_size())
end

local function find_widget(wb, wdg)

   local hierarchy
   local function traverse(hi)
      if hi:get_widget() == wdg then
            hierarchy = hi
      end
      for _, child in ipairs(hi:get_children()) do
            traverse(child)
      end
   end
   traverse(wb._drawable._widget_hierarchy)
   return hierarchy
end

systray_hints.run = function ()

    local function show_hints()
        show_popup( get_geometry(find_widget(systray_hints.wibox, systray_hints.systray)) )
        get_key_input(total)
    end

    if not systray_hints.systray.visible then
        was_hidden = true
        systray_hints.systray.visible = true
        delay(0.05, function ()
            show_hints()
        end)
    else
        show_hints()
    end

end

return systray_hints