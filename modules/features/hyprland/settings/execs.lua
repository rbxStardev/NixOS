--- @module execs
--- @desc Defines startup commands and daemons executed when Hyprland launches.

--- @desc Event listener: Executes processes once upon Hyprland startup.
hl.on("hyprland.start", function(...)
	hl.exec_cmd("noctalia-shell &")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd("mpd-discord-rpc")
end)
