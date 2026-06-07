--- @module scrolling
--- @desc Configures the scrolling infinite-tape layout behavior.

hl.config({
	scrolling = {
		column_width = 0.5,
		explicit_column_widths = "0.35, 0.5, 0.65, 1.0",
		focus_fit_method = 1,
		follow_focus = true,
		follow_min_visible = 0.0,
		fullscreen_on_one_column = true,
	},
})
