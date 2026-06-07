--- @module gestures
--- @desc Configures touchpad swipe gestures mapping to workspace and shell actions.

local vars = require("variables")

-- Gesture configuration using the modern 0.55+ API format
hl.config({
	gestures = {
		workspace_swipe_distance = 700,
		workspace_swipe_cancel_ratio = 0.15,
		workspace_swipe_min_speed_to_force = 5,
		workspace_swipe_direction_lock = true,
		workspace_swipe_direction_lock_threshold = 10,
		workspace_swipe_create_new = true,
	},
})

-- Multi-finger trackpad gestures
hl.gesture({ fingers = vars.gestureFingersMore, direction = "horizontal", action = "workspace" })

hl.gesture({
	fingers = vars.gestureFingersMore,
	direction = "down",
	action = function()
		hl.exec_cmd("systemctl suspend-then-hibernate")
	end,
})

hl.gesture({
	fingers = vars.gestureFingers,
	direction = "up",
	action = "special",
	workspace_name = "special",
})

hl.gesture({
	fingers = vars.gestureFingers,
	direction = "down",
	action = "special",
	workspace_name = "special",
})
