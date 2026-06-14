--- Defines startup commands and daemons executed when Hyprland launches.
-- @module execs

-- Event listener: Executes processes once upon Hyprland startup.
hl.on("hyprland.start", function(...)
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

	hl.exec_cmd("uwsm app -- wl-paste --type text --watch cliphist store")
	hl.exec_cmd("uwsm app -- wl-paste --type image --watch cliphist store")
	hl.exec_cmd("uwsm app -- mpd-discord-rpc")
end)
