--- @module env
--- @desc Sets environment variables for the compositor session.
--- Note: Because UWSM is enabled in NixOS, most environment variables should ideally
--- reside in `~/.config/uwsm/env-hyprland`. These variables are kept here as a fallback
--- and for explicit cursor enforcement inside the Hyprland state.

local vars = require("variables")

hl.env("XCURSOR_THEME", vars.cursorTheme)
hl.env("XCURSOR_SIZE", tostring(vars.cursorSize))
hl.env("HYPRCURSOR_THEME", vars.cursorTheme)
hl.env("HYPRCURSOR_SIZE", tostring(vars.cursorSize))
