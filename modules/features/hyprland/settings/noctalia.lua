--- @module noctalia
--- @desc A dedicated abstraction layer for IPC communication with Noctalia / Quickshell.
--- Separating this logic makes keybinds cleaner and allows proactive state syncing.

local M = {}

-- Base IPC command prefix
local ipc_base = "noctalia-shell ipc call "

--- @desc Wraps an IPC command into a Hyprland dispatcher for keybinds.
--- @param command string The Quickshell command to execute.
--- @return table The dispatcher object to be used inside `hl.bind()`.
function M.action(command)
	return hl.dsp.exec_cmd(ipc_base .. command)
end

--- @desc Dispatches an immediate IPC sync command (does not return a dispatcher).
--- @param command string The Quickshell command to execute immediately.
function M.sync(command)
	hl.exec_cmd(ipc_base .. command)
end

--- @desc Event listener: Syncs the currently active workspace to Noctalia.
--- @param ws table The workspace object provided by the event.
function M.sync_workspace(ws)
	if ws then
		M.sync("workspace.update " .. tostring(ws.id))
	end
end

--- @desc Event listener: Syncs the active window title to Noctalia.
--- @param win table The window object provided by the event.
function M.sync_window(win)
	if win and win.title then
		-- Escape quotes safely to prevent shell injection via window title
		local safe_title = string.gsub(win.title, "'", "\\'")
		M.sync("window.update '" .. safe_title .. "'")
	end
end

-- Hook into native Hyprland events to push updates proactively
hl.on("workspace.active", M.sync_workspace)
hl.on("window.active", M.sync_window)

return M
