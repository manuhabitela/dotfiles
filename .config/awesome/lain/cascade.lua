--[[

     Licensed under GNU General Public License v2
      * (c) 2014,      projektile
      * (c) 2013,      Luca CPZ
      * (c) 2010-2012, Peter Hofmann

	https://github.com/lcpz/lain modified so that the casdade goes left from right
--]]

local floor  = math.floor
local screen = screen

local cascade = {
    name     = "cascade",
    nmaster  = 0,
    offset_x = 32,
    offset_y = 8,
    rcrd = {
      name     = "cascade_rcrd",
      nmaster  = 0,
      offset_x = 32,
      offset_y = 8,
    },
    tile = {
        name          = "cascadetile",
        nmaster       = 0,
        ncol          = 0,
        mwfact        = 0,
        offset_x      = 24,
        offset_y      = 32,
        extra_padding = 0,
    }
}

local function do_cascade(p, tiling, wa_forced_width, wa_forced_height)
    local t = p.tag or screen[p.screen].selected_tag
    local wa = p.workarea
    local cls = p.clients

    if #cls == 0 then return end

    -- Use custom dimensions if provided, otherwise use workarea dimensions
    local area_width = wa_forced_width or wa.width
    local area_height = wa_forced_height or wa.height

    if not tiling then
        -- Cascade windows.

        local num_c
        if cascade.nmaster > 0 then
            num_c = cascade.nmaster
        else
            num_c = t.master_count
        end

        -- Opening a new window will usually force all existing windows to
        -- get resized. This wastes a lot of CPU time. So let's set a lower
        -- bound to "how_many": This wastes a little screen space but you'll
        -- get a much better user experience.
        local how_many = (#cls >= num_c and #cls) or num_c

        local current_offset_x = (#cls > 1) and (cascade.offset_x * (how_many - 1)) or 5
        local current_offset_y = (#cls > 1) and (cascade.offset_y * (how_many - 1)) or 5

        -- Add 20px gap around the whole cascade
        local gap = 20
        local available_width = area_width - (2 * gap)
        local available_height = area_height - (2 * gap)

        -- Iterate.
        for i = 1,#cls,1 do
            local c = cls[i]
            local g = {}

            g.x      = wa.x + gap + (i - 1) * cascade.offset_x
            g.y      = wa.y + gap + (i - 1) * cascade.offset_y
            g.width  = available_width - current_offset_x
            g.height = available_height - current_offset_y

            if g.width  < 1 then g.width  = 100 end
            if g.height < 1 then g.height = 100 end

            -- Ensure windows stay within the specified area
            -- if g.x + g.width > wa.x + area_width then
            --     g.width = wa.x + area_width - g.x
            -- end
            -- if g.y + g.height > wa.y + area_height then
            --     g.height = wa.y + area_height - g.y
            -- end

            p.geometries[c] = g
        end
    else
        -- Layout with one fixed column meant for a master window. Its
        -- width is calculated according to mwfact. Other clients are
        -- cascaded or "tabbed" in a slave column on the right.

        --         (1)                 (2)                 (3)                 (4)
        --   +----------+---+    +----------+---+    +----------+---+    +----------+---+
        --   |          |   |    |          | 3 |    |          | 4 |    |         +---+|
        --   |          |   | -> |          |   | -> |         +---++ -> |        +---+|+
        --   |  1       | 2 |    |  1      +---++    |  1      | 3 ||    |  1    +---+|+|
        --   |          |   |    |         | 2 ||    |        +---++|    |      +---+|+ |
        --   |          |   |    |         |   ||    |        | 2 | |    |      | 2 |+  |
        --   +----------+---+    +---------+---++    +--------+---+-+    +------+---+---+

        local mwfact
        if cascade.tile.mwfact > 0 then
            mwfact = cascade.tile.mwfact
        else
            mwfact = t.master_width_factor
        end

        -- Make slave windows overlap main window? Do this if ncol is 1.
        -- local overlap_main
        -- if cascade.tile.ncol > 0 then
        --     overlap_main = cascade.tile.ncol
        -- else
        --     overlap_main = t.column_count
        -- end
        -- Manu's override: don't overlap main window
        overlap_main = 0

        -- Minimum space for slave windows? See cascade.tile.lua.
        local num_c
        if cascade.tile.nmaster > 0 then
            num_c = cascade.tile.nmaster
        else
            num_c = t.master_count
        end

        local how_many = (#cls - 1 >= num_c and (#cls - 1)) or num_c

        local current_offset_x = cascade.tile.offset_x * (how_many - 1)
        local current_offset_y = cascade.tile.offset_y * (how_many - 1)

        if #cls <= 0 then return end

        -- Main column, fixed width and height.
        local c = cls[1]
        local g = {}
        -- Rounding is necessary to prevent the rendered size of slavewid
        -- from being 1 pixel off when the result is not an integer.
        local mainwid = floor(area_width * mwfact)
        local slavewid = area_width - mainwid

        if overlap_main == 1 then
            g.width = area_width

            -- The size of the main window may be reduced a little bit.
            -- This allows you to see if there are any windows below the
            -- main window.
            -- This only makes sense, though, if the main window is
            -- overlapping everything else.
            g.width = g.width - cascade.tile.extra_padding
        else
            g.width = mainwid
        end

        g.height = area_height
        g.x = wa.x
        g.y = wa.y

        if g.width < 1  then g.width  = 1 end
        if g.height < 1 then g.height = 1 end

        p.geometries[c] = g

        -- Remaining clients stacked in slave column, new ones on top.
        if #cls <= 1 then return end
        for i = 2,#cls do
            c = cls[i]
            g = {}

            g.width  = slavewid - current_offset_x
            g.height = area_height - current_offset_y

            -- g.x = wa.x + mainwid + (how_many - (i - 1)) * cascade.tile.offset_x
            -- Manu's override: change stacking order
            g.x = wa.x + mainwid + (cascade.tile.offset_x * (how_many - 1)) + (-1 * (how_many - (i - 1)) * cascade.tile.offset_x)
            g.y = wa.y + (i - 2) * cascade.tile.offset_y

            -- Ensure windows stay within the specified area
            if g.x + g.width > wa.x + area_width then
                g.width = wa.x + area_width - g.x
            end
            if g.y + g.height > wa.y + area_height then
                g.height = wa.y + area_height - g.y
            end

            if g.width < 1  then g.width  = 1 end
            if g.height < 1 then g.height = 1 end

            p.geometries[c] = g
        end
    end
end

function cascade.tile.arrange(p)
    return do_cascade(p, true)
end

function cascade.arrange(p)
    return do_cascade(p, false)
end

function cascade.rcrd.arrange(p)
    if is_4k_screen then
        return do_cascade(p, false, 2880, 2160)
    elseif big_screen then
        return do_cascade(p, false, 1920, 1440)
    else
        return do_cascade(p, false, 1920, 1080)
    end
end

return cascade
