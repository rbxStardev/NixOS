local vars = require("variables")

hl.config({
	decoration = {
		rounding = vars.windowRounding,
		rounding_power = vars.windowRoundingPower,

		blur = {
			enabled = vars.blurEnabled,
			size = vars.blurSize,
			passes = vars.blurPasses,
			ignore_opacity = true, -- Allows opacity blurring
			xray = vars.blurXray,
			vibrancy = vars.blurVibrancy,
			popups = vars.blurPopups,
			input_methods = vars.blurInputMethods,
			special = vars.blurSpecialWs,
		},

		shadow = {
			enabled = vars.shadowEnabled,
			range = vars.shadowRange,
			render_power = vars.shadowRenderPower,
		},
	},
})
