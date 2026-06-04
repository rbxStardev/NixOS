local variables = {
	-- ### Hyprland ###
	-- Apps
	terminal = "foot",
	browser = "firefox",
	editor = "hx",
	fileExplorer = "yazi",
	-- QuickshellConfig
	quickshellIpc = "noctalia-shell ipc call",
	-- Touchpad
	touchpadDisableTyping = true,
	touchpadScrollFactor = 0.3,
	workspaceSwipeFingers = 4,
	gestureFingers = 3,
	gestureFingersMore = 4,
	-- Blur
	blurEnabled = true,
	blurSpecialWs = true,
	blurPopups = true,
	blurInputMethods = true,
	blurSize = 7,
	blurPasses = 3,
	blurVibrancy = 0.1696,
	blurXray = false,
	-- Shadow
	shadowEnabled = true,
	shadowRange = 4,
	shadowRenderPower = 3,
	-- Gaps
	workspaceGaps = 20,
	windowGapsIn = 5,
	windowGapsOut = 10,
	singleWindowGapsOut = 10,
	-- Window Styling
	windowOpacity = 0.95,
	windowRounding = 0,
	windowRoundingPower = 0,
	windowBorderSize = 1,
	-- Misc
	curse = true,
	volumeStep = 10, -- In percent
	cursorTheme = "phinger-cursors-gruvbox-material",
	cursorSize = 24,
	-- ### Keybinds ###
	-- Workspaces
	kbMoveWinToWs = "SUPER+ALT",
	kbMoveWinToWsGroup = "CTRL+SUPER+ALT",
	kbGoToWs = "SUPER",
	kbGoToWsGroup = "CTRL+SUPER",
	kbNextWs = "CTRL+SUPER + right",
	kbPrevWs = "CTRL+SUPER + left",
	kbToggleSpecialWs = "SUPER + S",
	-- Window Groups
	kbWindowGroupCycleNext = "ALT + TAB",
	kbWindowGroupCyclePrev = "SHIFT+ALT + TAB",
	kbUngroup = "SUPER + U",
	kbToggleGroup = "SUPER + Comma",
	-- Window Actions
	kbMoveWindow = "SUPER + Z",
	kbResizeWindow = "SUPER + X",
	kbWindowPip = "SUPER+ALT + Backslash",
	kbPinWindow = "SUPER + P",
	kbWindowFullscreen = "SUPER + F",
	kbWindowBorderedFullscreen = "SUPER+ALT + F",
	kbToggleWindowFloating = "SUPER+ALT + Space",
	kbCloseWindow = "SUPER + Q",
	-- Special Workspace Toggles
	kbSystemMonitor = "CTRL+SHIFT + Escape",
	kbMusic = "SUPER + M",
	kbCommunication = "SUPER + D",
	kbTodo = "SUPER + R",
	-- Apps
	kbTerminal = "SUPER + T",
	kbBrowser = "SUPER + W",
	kbEditor = "SUPER + C",
	kbFileExplorer = "SUPER + E",
	-- Misc
	kbSession = "CTRL+ALT + Delete",
	kbClearNotifs = "CTRL+ALT + C",
	kbShowPanels = "SUPER + K",
	kbLock = "SUPER + L",
	kbRestoreLock = "SUPER+ALT + L",
	kbWallpaperPicker = "SUPER+SHIFT + W",
}

return variables
