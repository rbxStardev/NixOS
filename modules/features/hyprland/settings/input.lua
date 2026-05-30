local vars = require("variables")

hl.config({
	input = {
		kb_layout = "br",
		kb_variant = "abnt2",
		numlock_by_default = false,
		repeat_rate = 35,
		repeat_delay = 250,
		focus_on_close = 1,
		touchpad = {
			disable_while_typing = vars.touchpadDisableTyping,
			natural_scroll = true,
			scroll_factor = vars.touchpadScrollFactor,
		},
	},

	binds = {
		scroll_event_delay = 0,
	},

	cursor = {
		hotspot_padding = 1,
	},
})
