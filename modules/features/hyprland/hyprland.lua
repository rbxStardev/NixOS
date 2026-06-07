--- @module hyprland
--- @desc Main entry point for the Hyprland Lua configuration.

-- Load variables and external settings
require("variables")
require("settings_init")

--- @desc Monitor configuration
-- Configures the primary monitor resolution, refresh rate, and scaling.
hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@144",
	position = "0x0",
	scale = 1,
})
