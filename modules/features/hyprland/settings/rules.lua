--- Target-specific overrides for windows, layers, and workspaces based on regex matching.
-- @module rules

local vars = require("variables")

-- ==========================================
-- [ Workspace Rules ]
-- ==========================================
-- Implement "smart gaps" (no gaps when only one window exists)
hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = vars.singleWindowGapsOut })
hl.workspace_rule({ workspace = "f[4]s[false]", gaps_out = vars.singleWindowGapsOut })

-- ==========================================
-- [ Layer Rules ]
-- ==========================================
-- Apply fade animation to background overlay layers
local fadeLayers = { "hyprpicker", "logout_dialog", "selection", "wayfreeze" }
for _, ns in ipairs(fadeLayers) do
	hl.layer_rule({ name = "fade-" .. ns, match = { namespace = ns }, animation = "fade" })
end

hl.layer_rule({
	name = "launcher-effects",
	match = { namespace = "launcher" },
	animation = "popin 80%",
	blur = true,
})

hl.layer_rule({
	name = "noctalia",
	match = {
		namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|backdrop|window-switcher)$",
	},
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})

-- ==========================================
-- [ Window Rules ]
-- ==========================================
-- Global overrides
hl.window_rule({
	name = "global-opacity",
	match = { fullscreen = false },
	opacity = tostring(vars.windowOpacity) .. " override",
})

-- Force specific productivity/media apps to be fully opaque
hl.window_rule({
	name = "opaque-apps",
	match = {
		class = "kitty|equibop|imv|swappy|krita|gimp|inkscape|darktable|resolve|kdenlive|shotcut|blender|godot",
	},
	opaque = true,
})

-- Center natively floating windows (e.g. Wayland dialogs)
hl.window_rule({
	name = "center-float-native",
	match = { float = true, xwayland = false },
	center = true,
})

-- Force specific apps to float
local floatApps =
	"guifetch|yad|zenity|wev|org.gnome.FileRoller|file-roller|blueman-manager|com.github.GradienceTeam.Gradience|feh|imv|system-config-printer|^ueberzugpp_.*"
hl.window_rule({ name = "auto-float-apps", match = { class = floatApps }, float = true })

-- Float system dialogs and file operations
hl.window_rule({
	name = "system-dialogs",
	match = {
		title = "(Select|Open)( a)? (File|Folder)(s)?|File (Operation|Upload)( Progress)?|.* Properties|Export Image as PNG|GIMP Crash Debug|Save As|Library",
	},
	float = true,
})

-- Hidden utilities fixes
hl.window_rule({
	name = "ueberzugpp",
	match = { class = "^(ueberzugpp.*)$" },
	float = true,
	no_anim = true,
	no_focus = true,
	no_initial_focus = true,
})

-- Specific UI dimension rules
hl.window_rule({
	name = "nmtui-kitty",
	match = { class = "kitty", title = "nmtui" },
	float = true,
	size = "60% 70%",
	center = true,
})
hl.window_rule({
	name = "gnome-settings",
	match = { class = "org.gnome.Settings" },
	float = true,
	size = "70% 80%",
	center = true,
})
hl.window_rule({
	name = "pavucontrol-fix",
	match = { class = "org.pulseaudio.pavucontrol|yad-icon-browser" },
	float = true,
	size = "60% 70%",
	center = true,
})

-- Force specific applications into designated special workspaces
hl.window_rule({ name = "ws-sysmon", match = { class = "btop" }, workspace = "special:sysmon" })
hl.window_rule({
	name = "ws-music",
	match = { class = "feishin|Spotify|Supersonic|Cider|com.github.th_ch.youtube_music|Plexamp" },
	workspace = "special:music",
})
hl.window_rule({
	name = "ws-comm",
	match = { class = "discord|equibop|vesktop|whatsapp" },
	workspace = "special:communication",
})
hl.window_rule({ name = "ws-todo", match = { class = "Todoist" }, workspace = "special:todo" })

-- Gaming and Steam tweaks
hl.window_rule({ name = "steam-rounding", match = { class = "steam" }, rounding = 10 })
hl.window_rule({ name = "steam-friends", match = { class = "steam", title = "Friends List" }, float = true })
hl.window_rule({
	name = "games-performance",
	match = { class = "(steam_app_(default|[4, 8-15]+))|gamescope" },
	opaque = true,
	immediate = true,
	idle_inhibit = "always",
})

-- XWayland contextual menu artifact fixes
hl.window_rule({
	name = "xwayland-menu-fix",
	match = { xwayland = true, title = "win[4, 8-15]+" },
	no_blur = true,
	no_dim = true,
	no_shadow = true,
	rounding = 10,
})

-- Picture-in-Picture layout
hl.window_rule({
	name = "pip-mode",
	match = { title = "Picture(-| )in(-| )[Pp]icture" },
	float = true,
	pin = true,
	keep_aspect_ratio = true,
	move = "100%-w-2% 100%-w-3%",
})
