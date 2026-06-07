--- @module general
--- @desc Defines core compositor behavior, layout engine settings, and gap sizes.

local vars = require("variables")

hl.config({
	general = {
		layout = "dwindle",
		allow_tearing = false,
		gaps_workspaces = vars.workspaceGaps,
		gaps_in = vars.windowGapsIn,
		gaps_out = vars.windowGapsOut,
		border_size = vars.windowBorderSize,
	},

	dwindle = {
		preserve_split = true,
		smart_split = true,
		smart_resizing = true,
	},
})
