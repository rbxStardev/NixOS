local vars = require("variables")

-- Apps and utils
hl.bind(vars.kbSession, hl.dsp.exec_cmd(vars.quickshellIpc .. " sessionMenu toggle"))
hl.bind(vars.kbLock, hl.dsp.exec_cmd(vars.quickshellIpc .. " sessionMenu lock"))
hl.bind(vars.kbWallpaperPicker, hl.dsp.exec_cmd(vars.quickshellIpc .. " plugin:wallcards toggle"))
hl.bind("Print", hl.dsp.exec_cmd(vars.quickshellIpc .. " plugin:screen-shot-and-record screenshot"))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd(vars.quickshellIpc .. " plugin:screen-shot-and-record screenshot"))
hl.bind("SUPER + V", hl.dsp.exec_cmd(vars.quickshellIpc .. " plugin:clipper toggle"))
hl.bind("SUPER + Period", hl.dsp.exec_cmd(vars.quickshellIpc .. " launcher emoji"))

-- Variable defined apps
hl.bind(vars.kbTerminal, hl.dsp.exec_cmd(vars.terminal))
hl.bind(vars.kbBrowser, hl.dsp.exec_cmd(vars.browser))
hl.bind(vars.kbEditor, hl.dsp.exec_cmd(vars.editor))
hl.bind(vars.kbFileExplorer, hl.dsp.exec_cmd(vars.fileExplorer))

-- Window and group management
hl.bind(vars.kbCloseWindow, hl.dsp.window.close())
hl.bind(vars.kbToggleWindowFloating, hl.dsp.window.float({ action = "toggle" }))
hl.bind(vars.kbWindowFullscreen, hl.dsp.window.fullscreen(0))
hl.bind(vars.kbWindowBorderedFullscreen, hl.dsp.window.fullscreen(1))
hl.bind(vars.kbPinWindow, hl.dsp.window.pin())
hl.bind(vars.kbToggleGroup, hl.dsp.layout("togglegroup"))
hl.bind(vars.kbUngroup, hl.dsp.layout("moveoutofgroup"))
hl.bind("SUPER + SHIFT + Comma", hl.dsp.layout("lockactivegroup toggle"))

-- Focus navigation
local dirs = { left = "l", right = "r", up = "u", down = "d" }
for key, dir in pairs(dirs) do
	hl.bind("SUPER + " .. key, hl.dsp.focus({ direction = dir }))
	hl.bind("SUPER+SHIFT + " .. key, hl.dsp.window.move({ direction = dir }))
end

-- Workspaces (Loop 1-10)
for i = 1, 10 do
	local key = i % 10
	hl.bind(vars.kbGoToWs .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(vars.kbMoveWinToWs .. " + " .. key, hl.dsp.window.move({ workspace = i }))
	hl.bind(vars.kbGoToWsGroup .. " + " .. key, function()
		local cur = hl.workspace.active().id
		local pos = cur % 10
		if pos == 0 then
			pos = 10
		end
		hl.dsp.focus({ workspace = (i - 1) * 10 + pos })
	end)
end

-- Special workspaces
hl.bind(vars.kbToggleSpecialWs, hl.dsp.workspace.toggle_special("special"))
hl.bind(vars.kbSystemMonitor, hl.dsp.workspace.toggle_special("sysmon"))
hl.bind(vars.kbMusic, hl.dsp.workspace.toggle_special("music"))
hl.bind(vars.kbCommunication, hl.dsp.workspace.toggle_special("communication"))
hl.bind(vars.kbTodo, hl.dsp.workspace.toggle_special("todo"))

-- Workspace navigation
hl.bind(vars.kbNextWs, hl.dsp.focus({ workspace = "+1" }), { repeating = true })
hl.bind(vars.kbPrevWs, hl.dsp.focus({ workspace = "-1" }), { repeating = true })
hl.bind("SUPER + Page_Up", hl.dsp.focus({ workspace = "-1" }), { repeating = true })
hl.bind("SUPER + Page_Down", hl.dsp.focus({ workspace = "+1" }), { repeating = true })

-- Window and group creationg
hl.bind(vars.kbWindowGroupCycleNext, hl.dsp.layout("changegroupactive f"), { repeating = true })
hl.bind(vars.kbWindowGroupCyclePrev, hl.dsp.layout("changegroupactive b"), { repeating = true })

hl.bind(vars.kbClearNotifs, hl.dsp.exec_cmd(vars.quickshellIpc .. " notifications clear"), { locked = true })
hl.bind(vars.kbRestoreLock, hl.dsp.exec_cmd(vars.quickshellIpc .. " sessionMenu lock"), { locked = true })
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd("systemctl suspend-then-hibernate"), { locked = true })

-- Media and brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(vars.quickshellIpc .. " brightness increase"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(vars.quickshellIpc .. " brightness decrease"), { locked = true })
hl.bind("CTRL + SUPER + Space", hl.dsp.exec_cmd(vars.quickshellIpc .. " media toggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(vars.quickshellIpc .. " media toggle"), { locked = true })
hl.bind("CTRL + SUPER + Equal", hl.dsp.exec_cmd(vars.quickshellIpc .. " media next"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(vars.quickshellIpc .. " media next"), { locked = true })

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

-- Mouse (bindm -> mouse = true)
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(vars.kbMoveWindow, hl.dsp.window.drag(), { mouse = true }) -- SUPER, Z
hl.bind(vars.kbResizeWindow, hl.dsp.window.resize(), { mouse = true }) -- SUPER, X

-- Release (bindr -> release = true)
hl.bind("SUPER + SUPER_L", hl.dsp.exec_cmd(vars.quickshellIpc .. " launcher toggle"), { release = true })
