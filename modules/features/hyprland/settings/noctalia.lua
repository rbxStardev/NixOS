--- A dedicated abstraction layer for IPC communication with Noctalia v5.
-- Noctalia v5 handles Wayland state natively via wlr-protocols, so manual
-- workspace and window state synchronization hooks are no longer required.
-- @module noctalia

local M = {}

-- The new IPC command prefix for Noctalia v5
local ipc_base = "noctalia msg "

--- Wraps an IPC command into a Hyprland dispatcher for keybinds.
-- @function M.action
-- @tparam string command The Noctalia subcommand to execute.
-- @treturn table The dispatcher object to be used inside `hl.bind()`.
-- @usage hl.bind("SUPER + A", noctalia.action("panel-toggle launcher"))
function M.action(command)
	return hl.dsp.exec_cmd(ipc_base .. command)
end

--- Dispatches an immediate IPC sync command (does not return a dispatcher).
-- @function M.sync
-- @tparam string command The Noctalia subcommand to execute immediately.
function M.sync(command)
	hl.exec_cmd(ipc_base .. command)
end

return M
