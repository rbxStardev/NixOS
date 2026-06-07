--- @module keybinds
--- @desc Maps keyboard combinations to compositor actions, applications, and IPC commands.

local vars = require("variables")
local noctalia = require("settings.noctalia")

-- ==========================================
-- [ Shell & Noctalia Integration ]
-- ==========================================
hl.bind(vars.kbSession, noctalia.action("sessionMenu toggle"))
hl.bind(vars.kbLock, noctalia.action("sessionMenu lock"))
hl.bind(vars.kbWallpaperPicker, noctalia.action("plugin:wallcards toggle"))
hl.bind("Print", noctalia.action("plugin:screen-shot-and-record screenshot"))
hl.bind("SUPER + SHIFT + S", noctalia.action("plugin:screen-shot-and-record screenshot"))
hl.bind("SUPER + V", noctalia.action("plugin:clipper toggle"))
hl.bind("SUPER + Period", noctalia.action("launcher emoji"))
hl.bind(vars.kbClearNotifs, noctalia.action("notifications clear"), { locked = true })
hl.bind(vars.kbRestoreLock, noctalia.action("sessionMenu lock"), { locked = true })

-- ==========================================
-- [ Application Launchers ]
-- ==========================================
hl.bind(vars.kbTerminal, hl.dsp.exec_cmd(vars.terminal))
hl.bind(vars.kbBrowser, hl.dsp.exec_cmd(vars.browser))
hl.bind(vars.kbEditor, hl.dsp.exec_cmd(vars.terminal .. " -e " .. vars.editor))
hl.bind(vars.kbFileExplorer, hl.dsp.exec_cmd(vars.terminal .. " -e " .. vars.fileExplorer))
hl.bind("SUPER + SUPER_L", noctalia.action("launcher toggle"), { release = true })

-- ==========================================
-- [ Window Management ]
-- ==========================================
hl.bind(vars.kbCloseWindow, hl.dsp.window.close())
hl.bind(vars.kbToggleWindowFloating, hl.dsp.window.float({ action = "toggle" }))
hl.bind(vars.kbWindowFullscreen, hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(vars.kbWindowBorderedFullscreen, hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(vars.kbPinWindow, hl.dsp.window.pin())

-- ==========================================
-- [ Group (Tabbed) Management ]
-- ==========================================
hl.bind(vars.kbToggleGroup, hl.dsp.group.toggle())
hl.bind(vars.kbUngroup, hl.dsp.window.move({ out_of_group = true }))
hl.bind("SUPER + SHIFT + Comma", hl.dsp.group.lock_active({ action = "toggle" }))
hl.bind(vars.kbWindowGroupCycleNext, hl.dsp.group.next(), { repeating = true })
hl.bind(vars.kbWindowGroupCyclePrev, hl.dsp.group.prev(), { repeating = true })

-- ==========================================
-- [ Focus and Directional Movement ]
-- ==========================================
local dirs = { left = "l", right = "r", up = "u", down = "d" }
for key, dir in pairs(dirs) do
	hl.bind("SUPER + " .. key, hl.dsp.focus({ direction = dir }))
	hl.bind("SUPER+SHIFT + " .. key, hl.dsp.window.move({ direction = dir }))
end

-- ==========================================
-- [ Workspaces & Paging ]
-- ==========================================
--- @desc Dynamically creates keybinds for workspaces 1 through 10.
for i = 1, 10 do
	local key = i % 10

	-- Standard workspace focusing and moving
	hl.bind(vars.kbGoToWs .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(vars.kbMoveWinToWs .. " + " .. key, hl.dsp.window.move({ workspace = i }))

	-- Complex Group Workspace Logic using Lambda functions
	-- Requires explicit hl.dispatch() to execute the generated table.
	hl.bind(vars.kbGoToWsGroup .. " + " .. key, function()
		local active_ws = hl.get_active_workspace()
		if not active_ws then
			return
		end -- Fallback during initialization

		local cur = active_ws.id
		local pos = cur % 10
		if pos == 0 then
			pos = 10
		end

		hl.dispatch(hl.dsp.focus({ workspace = (i - 1) * 10 + pos }))
	end)
end

-- Special Workspaces
hl.bind(vars.kbToggleSpecialWs, hl.dsp.workspace.toggle_special("special"))
hl.bind(vars.kbSystemMonitor, hl.dsp.workspace.toggle_special("sysmon"))
hl.bind(vars.kbMusic, hl.dsp.workspace.toggle_special("music"))
hl.bind(vars.kbCommunication, hl.dsp.workspace.toggle_special("communication"))
hl.bind(vars.kbTodo, hl.dsp.workspace.toggle_special("todo"))

-- Workspace scrolling/paging
hl.bind(vars.kbNextWs, hl.dsp.focus({ workspace = "+1" }), { repeating = true })
hl.bind(vars.kbPrevWs, hl.dsp.focus({ workspace = "-1" }), { repeating = true })
hl.bind("SUPER + Page_Up", hl.dsp.focus({ workspace = "-1" }), { repeating = true })
hl.bind("SUPER + Page_Down", hl.dsp.focus({ workspace = "+1" }), { repeating = true })

-- ==========================================
-- [ Hardware & Media Controls ]
-- ==========================================
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd("systemctl suspend-then-hibernate"), { locked = true })

-- Brightness
hl.bind("XF86MonBrightnessUp", noctalia.action("brightness increase"), { locked = true })
hl.bind("XF86MonBrightnessDown", noctalia.action("brightness decrease"), { locked = true })

-- Media Control
hl.bind("CTRL + SUPER + Space", noctalia.action("media toggle"), { locked = true })
hl.bind("XF86AudioPlay", noctalia.action("media toggle"), { locked = true })
hl.bind("CTRL + SUPER + Equal", noctalia.action("media next"), { locked = true })
hl.bind("XF86AudioNext", noctalia.action("media next"), { locked = true })

-- Volume Control (using Wireplumber)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)

-- ==========================================
-- [ Mouse Controls ]
-- ==========================================
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(vars.kbMoveWindow, hl.dsp.window.drag(), { mouse = true })
hl.bind(vars.kbResizeWindow, hl.dsp.window.resize(), { mouse = true })
