-- awesome_mode: api-level=5:screen=on
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local ruled = require("ruled")
local wibox = require("wibox")
require("awful.autofocus")

awful.spawn("autorandr -c")

local dpi	= beautiful.xresources.apply_dpi

awesome.set_preferred_icon_size(128)

naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)

tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        awful.layout.suit.corner.nw,
        awful.layout.suit.tile,
        awful.layout.suit.floating,
        awful.layout.suit.spiral,
    })
end)

screen.connect_signal("request::desktop_decoration", function(s)
	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
end)

beautiful.init( gears.filesystem.get_configuration_dir() .. "theme.lua")

--globals for andOrlando widgets
RUBATO_DIR = "plugins.rubato."

require ("keybinds")
require ("ui")

-- client management {{{
client.connect_signal("mouse::enter", function(c)
	c:activate { context = "mouse_enter", raise = false }
end)

client.connect_signal("request::manage", function(c)
    c:move_to_screen(awful.screen.focused())
	if c.floating then
		awful.placement.centered(c)
		c:raise()
	else c:to_secondary_section() end
    c:activate{raise = true}
    if not c.requests_no_titlebar then c:emit_signal("request::titlebars", c) end
end)

-- rules {{{
ruled.client.connect_signal("request::rules", function()
	ruled.client.append_rule {
		rule = {},
		except_any = { type = { "normal", "dialog" } },
		properties = { floating = true, placement = awful.placement.centered }
	}
	ruled.client.append_rule {
		rule_any = {
			class = { "Thunar", "Pcmanfm", "Galculator", "Nemo" }
		},
		properties = {
			floating= true,
			width	= dpi(650),
			height	= dpi(480)
		},
	}
end)
--}}}

-- {{{ Notifications
ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule       = { },
        properties = {
            screen           = awful.screen.focused,
            implicit_timeout = 5,
        }
    }
end)
-- }}}

-- Autostart {{{
awful.spawn("nm-applet")
--awful.spawn("blueman-applet")
awful.spawn("xfce4-clipman")
awful.spawn("redshift -O 4600K -P")
awful.spawn("picom --config " .. gears.filesystem.get_configuration_dir() .. "/configs/picom.conf")
awful.spawn("setxkbmap eu")
-- }}}
