local wibox = require "wibox"
local awful = require "awful"
local naughty = require "naughty"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local gears = require "gears"
local helpers = require "helpers"

local client = client
local naughty = naughty

local notifctl = require "ui.notifications"

local iconsdir = gears.filesystem.get_configuration_dir() .. "assets/titlebarbuttons/"
local mat_icons = gears.filesystem.get_configuration_dir() .. "assets/materialicons/"

local function bar_indic_notif()
    require("ui.bar.bar").notifcenter_filled()
end

local function bar_indic_no_notif()
    require("ui.bar.bar").notifcenter_cleared()
end

local function cross_enter (self, _)
    self:get_children_by_id('remove')[1]:set_image(gears.color.recolor_image(iconsdir .. "close.svg", beautiful.red))
end
local function cross_leave (self, _)
    self:get_children_by_id('remove')[1]:set_image(gears.color.recolor_image(iconsdir .. "close.svg", beautiful.fg_normal))
end

local main_widget

local entry_template = {
    widget = wibox.container.background,
    bg = beautiful.bg_focus,
    shape = beautiful.theme_shape,
    {
        widget = wibox.container.constraint,
        width = dpi(400),
        strategy = 'max',
        {
            layout = wibox.layout.fixed.vertical,
            {
                widget = wibox.container.background,
                bg = beautiful.bg_focus,
                fg = beautiful.fg_focus,
                forced_height = beautiful.get_font_height(beautiful.font_bold .. " 11"),
                {
                    widget = wibox.container.place,
                    fill_horizontal = true,
                    halign = 'right',
                    valign = 'bottom',
                    {
                        id = 'remove',
                        widget = wibox.widget.imagebox,
                        forced_height = beautiful.get_font_height(beautiful.font_bold .. " 11")/2,
                        forced_width = beautiful.get_font_height(beautiful.font_bold .. " 11"),
                    }
                }
            },
            {
                widget = wibox.container.margin,
                margins = { left = dpi(5), right = dpi(5), bottom = dpi(5) },
                {
                    layout = wibox.layout.fixed.horizontal,
                    spacing = dpi(5),
                    {
                        widget = wibox.container.place,
                        valign = 'center',
                        {
                            id = 'icon',
                            widget = wibox.widget.imagebox,
                            resize = true,
                            forced_width = 0,
                            forced_height = 0,
                            clip_shape = beautiful.theme_shape
                        }
                    },
                    {
                        widget = wibox.container.place,
                        valign = 'top',
                        {
                            layout = wibox.layout.fixed.vertical,
                            spacing = dpi(5),
                            {
                                id = 'title',
                                widget = wibox.widget.textbox,
                                font = beautiful.font_bold .. " 11",
                            },
                            {
                                id = 'text',
                                widget = wibox.widget.textbox,
                                font = beautiful.font_thin .. " 11",
                            }
                        }
                    }
                }
            }
        }
    }
}

main_widget = wibox.widget {
    layout = wibox.layout.fixed.vertical,
    spacing = dpi(5)
}

--this is basically just a simple header + layout to hold notifs
local app_revealer_template = {
    widget = wibox.container.background,
    shape = beautiful.theme_shape,
    {
        layout = wibox.layout.fixed.vertical,
        {
            id = 'revealer_top_bg',
            widget = wibox.container.background,
            forced_height = beautiful.get_font_height(beautiful.font_bold .. " 11") + dpi(10),
            bg = beautiful.bg_focus_dark,
            {
                widget = wibox.container.margin,
                margins = dpi(5),
                {
                    layout = wibox.layout.align.horizontal,
                    expand = 'inside',
                    {
                        id = 'reveal_button',
                        widget = wibox.widget.imagebox,
                        image = gears.color.recolor_image(mat_icons .. "expand_more.svg", beautiful.fg_normal)
                    },
                    {
                        widget = wibox.container.place,
                        halign = 'center',
                        fill_horizontal = true,
                        {
                            id = 'appname',
                            widget = wibox.widget.textbox,
                            font = beautiful.font .. " 10"
                        }
                    },
                    {
                        id = 'clear_button',
                        widget = wibox.widget.imagebox,
                        image = gears.color.recolor_image(mat_icons .. "clear_all.svg", beautiful.fg_normal)
                    }
                },
            }
        },
        {
            widget = wibox.container.background,
            bg = beautiful.bg_focus_dark,
            {
                id = 'notifs_margin',
                widget = wibox.container.margin,
                margins = { left = dpi(5), right = dpi(5) },
                {
                    id = 'notifs',
                    layout = wibox.layout.fixed.vertical,
                    spacing = dpi(3)
                }
            }
        }
    }
}

local function add_notif_widget(n)
    local w = wibox.widget(entry_template)
    w.app = n.app_name or 'undefined'

    local drawer
    --check if the app already has a drawer thingy
    for _, d in ipairs(main_widget:get_children()) do
        if d.app == w.app then
            drawer = d
            --move currently used drawer to the top
            main_widget:remove_widgets(drawer)
            main_widget:insert(1, drawer)
            break
        end
    end

    --if there are no recent notifications from the app we create a new drawer for them and add button magic
    if not drawer then
        drawer = wibox.widget(app_revealer_template)
        drawer:get_children_by_id('appname')[1].text = w.app
        drawer.app = w.app
        drawer.collapsed = true
        drawer.attached_notifs = {}
        drawer:get_children_by_id('reveal_button')[1]:add_button(awful.button {
            modifiers = {},
            button = 1,
            on_press = function ()
                if drawer.collapsed then
                    drawer:get_children_by_id('notifs')[1]:set_children(drawer.attached_notifs)
                    drawer:get_children_by_id('notifs_margin')[1].margins = dpi(5)
                    drawer:get_children_by_id('reveal_button')[1]:set_image(gears.color.recolor_image(mat_icons .. "expand_less.svg", beautiful.fg_normal))
                else
                    drawer:get_children_by_id('notifs')[1]:reset()
                    drawer:get_children_by_id('notifs_margin')[1].margins = 0
                    drawer:get_children_by_id('reveal_button')[1]:set_image(gears.color.recolor_image(mat_icons .. "expand_more.svg", beautiful.fg_normal))
                end
                drawer.collapsed = not drawer.collapsed
            end
        })
        helpers.pointer_on_focus(drawer:get_children_by_id('reveal_button')[1])
        drawer:get_children_by_id('clear_button')[1]:add_button(awful.button {
            modifiers = {},
            button = 1,
            on_press = function ()
                main_widget:remove_widgets(drawer)
                drawer = nil
                if #main_widget:get_children() == 0 then bar_indic_no_notif() end
                collectgarbage("collect")
            end
        })
        helpers.pointer_on_focus(drawer:get_children_by_id('clear_button')[1])
        main_widget:insert(1, drawer)
    end

    --create notification widget and add it to its apps' drawer
    w:get_children_by_id('remove')[1]:set_image(gears.color.recolor_image(iconsdir .. "close.svg", beautiful.fg_normal))
    w:get_children_by_id('remove')[1]:connect_signal("mouse::enter", function() cross_enter(w) end)
    w:get_children_by_id('remove')[1]:connect_signal("mouse::leave", function() cross_leave(w) end)
    w:get_children_by_id('title')[1]:set_markup_silently(n.title)
    w:get_children_by_id('text')[1]:set_markup_silently(n.message)
    if n.icon then
        w:get_children_by_id('icon')[1]:set_image(n.icon)
        w:get_children_by_id('icon')[1].forced_height = dpi(40)
        w:get_children_by_id('icon')[1].forced_width = dpi(40)
    end
    w:get_children_by_id('remove')[1]:add_button(
        awful.button {
            modifiers = {},
            button = 1,
            on_press = function ()
                w:get_children_by_id('remove')[1]:disconnect_signal("mouse::enter", cross_enter)
                w:get_children_by_id('remove')[1]:disconnect_signal("mouse::leave", cross_leave)
                --app_notifs[w.app]:get_children_by_id('notifs'):remove_widgets(w)
                drawer:get_children_by_id('notifs')[1]:remove_widgets(w)
                for i, e in ipairs(drawer.attached_notifs) do
                    if e == w then table.remove(drawer.attached_notifs, i); break end
                end
                drawer:get_children_by_id('appname')[1].text = drawer.app .. " (" .. #drawer.attached_notifs .. ")"
                if #drawer:get_children_by_id('notifs')[1]:get_children() == 0 then main_widget:remove_widgets(drawer) end
                if #main_widget:get_children() == 0 then bar_indic_no_notif() end
                collectgarbage("collect")
            end
        }
    )

    table.insert(drawer.attached_notifs, 1, w)
    drawer:get_children_by_id('appname')[1].text = drawer.app .. " (" .. #drawer.attached_notifs .. ")"
    if not drawer.collapsed then
        drawer:get_children_by_id('notifs')[1]:insert(1, w)
    end
end

local signals = notifctl.signals

local notifs_active, notifs_sound = true, true

local notifbox
notifbox = wibox.widget { --empty because it will be filled with the update function
    layout = wibox.layout.fixed.vertical,
    spacing = dpi(5),
    {
        layout = wibox.layout.align.horizontal,
        expand = 'inside',
        {
            id = 'toggle_dnd_bg',
            widget = wibox.container.background,
            forced_height = beautiful.get_font_height(beautiful.font .. " 11"),
            bg = beautiful.bg_focus_dark,
            shape = beautiful.theme_shape,
            buttons = awful.button {
                modifiers = {},
                button = 1,
                on_press = function ()
                    notifs_active = not notifs_active
                    if notifs_active == true then notifctl.enable_notifs() else notifctl.disable_notifs() end
                end
            },
            {
                widget = wibox.container.margin,
                margins = dpi(5),
                {
                    id = 'toggle_dnd',
                    widget = wibox.widget.imagebox,
                    forced_width = beautiful.get_font_height(beautiful.font .. " 11"),
                    image = gears.color.recolor_image(mat_icons .. "notifications_active.svg", beautiful.fg_focus),
                    resize = true,
                },
            }
        },
        {
            widget = wibox.container.margin,
            margins = {
                left = dpi(5),
                right = dpi(5)
            },
            {
                widget = wibox.container.background,
                forced_height = beautiful.get_font_height(beautiful.font_bold .. " 11") + dpi(10),
                bg = beautiful.bg_focus_dark,
                shape = beautiful.theme_shape,
                {
                    widget = wibox.container.margin,
                    margins = dpi(5),
                    {
                        widget = wibox.container.place,
                        halign = 'center',
                        fill_horizontal = true,
                        {
                            widget = wibox.widget.textbox,
                            text = "Notifications",
                            font = beautiful.font_bold .. " 11"
                        }
                    }
                }
            }
        },
        {
            id = 'toggle_sound_bg',
            widget = wibox.container.background,
            forced_height = beautiful.get_font_height(beautiful.font .. " 11"),
            bg = beautiful.bg_focus_dark,
            shape = beautiful.theme_shape,
            buttons = awful.button {
                modifiers = {},
                button = 1,
                on_press = function ()
                    notifs_sound = not notifs_sound
                    if notifs_sound == true then notifctl.enable_sound() else notifctl.disable_sound() end
                end
            },
            {
                widget = wibox.container.margin,
                margins = dpi(5),
                {
                    id = 'toggle_sound',
                    widget = wibox.widget.imagebox,
                    forced_width = beautiful.get_font_height(beautiful.font .. " 11"),
                    image = gears.color.recolor_image(mat_icons .. "volume_up.svg", beautiful.fg_focus),
                    resize = true,
                },
            }
        },
    },
    main_widget
}

--helpers.pointer_on_focus(notifbox:get_children_by_id('clear_button')[1])
helpers.pointer_on_focus(notifbox:get_children_by_id('toggle_dnd_bg')[1])
helpers.pointer_on_focus(notifbox:get_children_by_id('toggle_sound_bg')[1])

signals:connect_signal("display::enabled", function ()
    notifbox:get_children_by_id('toggle_dnd')[1]:set_image(gears.color.recolor_image(mat_icons .. "notifications_active.svg", beautiful.fg_focus))
    notifs_active = true
end)

signals:connect_signal("display::disabled", function ()
    notifs_active = false
    notifbox:get_children_by_id('toggle_dnd')[1]:set_image(gears.color.recolor_image(mat_icons .. "notifications_off.svg", beautiful.fg_focus))
end)

signals:connect_signal("sound::enabled", function ()
    notifs_sound = true
    notifbox:get_children_by_id('toggle_sound')[1]:set_image(gears.color.recolor_image(mat_icons .. "volume_up.svg", beautiful.fg_focus))
end)

signals:connect_signal("sound::disabled", function ()
    notifs_sound = false
    notifbox:get_children_by_id('toggle_sound')[1]:set_image(gears.color.recolor_image(mat_icons .. "volume_off.svg", beautiful.fg_focus))
end)

local blacklisted_appnames = { "Spotify", "NetworkManager" }
local blacklisted_titles = { "Launching Application", "battery low!" }

local function check_list (n)
    for _, an in ipairs(blacklisted_appnames) do
        if an == n.app_name then return true end
    end
    for _, nt in ipairs(blacklisted_titles) do
        if nt == n.title then return true end
    end
    return false
end

naughty.connect_signal("request::display", function(n)
    if (not check_list(n)) and (string.lower(client.focus.class) ~= n.app_name) then --ignore some notifications
        add_notif_widget(n)
        bar_indic_notif()
    end
end)

client.connect_signal("property::active", function (c)
    --most apps report their name via class so that should be alright
    if c.class then
        local cname = string.lower(c.class) or nil
        local drawer
        for _, entry in ipairs(main_widget:get_children()) do
            if string.lower(entry.app) == cname then
                drawer = entry
            end
        end
        main_widget:remove_widgets(drawer)
        if #main_widget:get_children() == 0 then bar_indic_no_notif() end
    end
end)

return notifbox
