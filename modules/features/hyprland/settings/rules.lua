local vars = require("variables")

-- Configuração de Smart Gaps (Gaps apenas quando há mais de uma janela)
hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = vars.singleWindowGapsOut })
hl.workspace_rule({ workspace = "f[4]s[false]", gaps_out = vars.singleWindowGapsOut })

-- Animações de Fade para ferramentas de sistema
local fadeLayers = { "hyprpicker", "logout_dialog", "selection", "wayfreeze" }
for _, ns in ipairs(fadeLayers) do
	hl.layer_rule({ name = "fade-" .. ns, match = { namespace = ns }, animation = "fade" })
end

-- Regras para o Launcher (Noctalia)
hl.layer_rule({
	name = "launcher-effects",
	match = { namespace = "launcher" },
	animation = "popin 80%",
	blur = true,
})

-- Regras para o Background e Shell
hl.layer_rule({
	name = "noctalia",
	match = { namespace = "noctalia-background-.*$" },
	blur = true,
	blur_popups = true,
	ignore_alpha = 0.5,
})

hl.layer_rule({
	name = "region-selector-no-anim",
	match = { namespace = "noctalia-shell:regionSelector" },
	no_anim = true,
})

-- Opacidade condicional (usa vars.windowOpacity)
hl.window_rule({
	name = "global-opacity",
	match = { fullscreen = false },
	opacity = vars.windowOpacity .. " override",
})

-- Janelas que devem ser sempre opacas
hl.window_rule({
	name = "opaque-apps",
	match = {
		class = "foot|equibop|org.quickshell|imv|swappy|krita|gimp|inkscape|darktable|resolve|kdenlive|shotcut|blender|godot",
	},
	opaque = true,
})

-- Centralização automática de janelas flutuantes que não são XWayland
hl.window_rule({
	name = "center-float-native",
	match = { float = true, xwayland = false },
	center = true,
})

-- Apps que sempre abrem em modo flutuante
local floatApps =
	"guifetch|yad|zenity|wev|org.gnome.FileRoller|file-roller|blueman-manager|com.github.GradienceTeam.Gradience|feh|imv|system-config-printer|org.quickshell|^ueberzugpp_.*"
hl.window_rule({ name = "auto-float-apps", match = { class = floatApps }, float = true })

-- Diálogos comuns do sistema (Save As, Open File, etc)
hl.window_rule({
	name = "system-dialogs",
	match = {
		title = "(Select|Open)( a)? (File|Folder)(s)?|File (Operation|Upload)( Progress)?|.* Properties|Export Image as PNG|GIMP Crash Debug|Save As|Library",
	},
	float = true,
})

hl.window_rule({
	name = "ueberzugpp",
	match = { class = "^(ueberzugpp.*)$" },
	float = true,
	no_anim = true,
	no_focus = true,
	no_initial_focus = true,
})

-- foot / NMTUI
hl.window_rule({
	name = "nmtui-foot",
	match = { class = "foot", title = "nmtui" },
	float = true,
	size = "60% 70%",
	center = 1,
})

-- Configurações e Controle de Áudio
hl.window_rule({
	name = "gnome-settings",
	match = { class = "org.gnome.Settings" },
	float = true,
	size = "70% 80%",
	center = 1,
})

hl.window_rule({
	name = "pavucontrol-fix",
	match = { class = "org.pulseaudio.pavucontrol|yad-icon-browser" },
	float = true,
	size = "60% 70%",
	center = 1,
})

-- Workspaces Especiais (Scratchpads)
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

-- Steam e Apps de Jogos
hl.window_rule({ name = "steam-rounding", match = { class = "steam" }, rounding = 10 })
hl.window_rule({ name = "steam-friends", match = { class = "steam", title = "Friends List" }, float = true })
hl.window_rule({
	name = "games-performance",
	match = { class = "(steam_app_(default|[4, 8-15]+))|gamescope" },
	opaque = true,
	immediate = true,
	idle_inhibit = "always",
})

-- Janelas XWayland genéricas (geralmente menus de apps legados)
hl.window_rule({
	name = "xwayland-menu-fix",
	match = { xwayland = 1, title = "win[4, 8-15]+" },
	no_blur = true,
	no_dim = true,
	no_shadow = true,
	rounding = 10,
})

-- Picture-in-Picture
hl.window_rule({
	name = "pip-mode",
	match = { title = "Picture(-| )in(-| )[Pp]icture" },
	float = true,
	pin = true,
	keep_aspect_ratio = true,
	move = "100%-w-2% 100%-w-3%",
})
