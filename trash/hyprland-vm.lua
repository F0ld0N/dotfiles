-- =============================================================================
-- ТЕСТОВЫЙ КОНФИГ HYPRLAND ДЛЯ ВИРТУАЛЬНОЙ МАШИНЫ (VirtualBox / VMware / QEMU)
-- Скопируй в ~/.config/hypr/hyprland.lua ТОЛЬКО внутри виртуалки для тестов!
-- =============================================================================

-- =============================================================================
-- ИНИЦИАЛИЗАЦИЯ И МОНИТОРЫ (Для ВМ нужен универсальный монитор Virtual-1)
-- =============================================================================
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

-- =============================================================================
-- ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ И ПРИЛОЖЕНИЯ
-- =============================================================================
local terminal = "ghostty"
local fileManager = "Thunar"
local menu = "sherlock"
local browser = "librewolf"

_G.terminal = terminal
_G.fileManager = fileManager
_G.menu = menu
_G.browser = browser

-- =============================================================================
-- АВТОЗАПУСК (СОБЫТИЙНЫЙ СЛУШАТЕЛЬ)
-- =============================================================================
hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("~/.config/hypr/scripts/start_wallpaper.sh")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("hypridle")
end)

-- =============================================================================
-- ПЕРЕМЕННЫЕ ОКРУЖЕНИЯ
-- =============================================================================
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("STEAM_FORCE_DESKTOPUI_SCALING", "1")

-- ДЛЯ ВИРТУАЛКИ:
-- Строки NVIDIA закомментированы (в виртуалке нет физической NVIDIA карты, из-за них падает Wayland):
-- hl.env("LIBVA_DRIVER_NAME", "nvidia")
-- hl.env("GBM_BACKEND", "nvidia-drm")
-- hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

-- Разрешаем запуск на виртуальном/программном рендере:
hl.env("WLR_RENDERER_ALLOW_SOFTWARE", "1")

-- =============================================================================
-- ОСНОВНЫЕ НАСТРОЙКИ КОМПОЗИТОРА
-- =============================================================================
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 20,
		border_size = 5,
		col = {
			active_border = { colors = { "rgb(7D8FFF)", "rgb(5E74FF)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 10,
		rounding_power = 2,
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		preserve_split = true,
	},

	master = {
		new_status = "master",
	},

	misc = {
		force_default_wallpaper = 1,
		disable_hyprland_logo = true,
	},

	input = {
		kb_layout = "us,ru",
		kb_variant = "",
		kb_model = "",
		kb_options = "grp:caps_toggle",
		kb_rules = "",

		follow_mouse = 1,
		sensitivity = -0.8,

		touchpad = {
			natural_scroll = true,
		},
	},

	gestures = {},
})

-- =============================================================================
-- КРИВЫЕ И АНИМАЦИОННЫЕ ПРОФИЛИ
-- =============================================================================
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-- Конфигурация устройств ввода
hl.device({
	name = "elan0501:00-04f3:3019-touchpad",
	sensitivity = 0,
})

-- =============================================================================
-- ПРАВИЛА ОКОН (WINDOW RULES)
-- =============================================================================
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	name = "thunar-opacity",
	match = { class = "Thunar" },
	opacity = "0.92 0.85",
})

hl.window_rule({
	name = "floating-center-win",
	match = { class = "^hyprland-floating-center$" },
	float = true,
	center = true,
	size = { 600, 400 },
})

hl.window_rule({
	name = "mpv-float",
	match = { class = "^mpv$" },
	float = true,
	center = true,
	size = { 1280, 720 },
})

hl.window_rule({
	name = "viewnior-float",
	match = { class = "^viewnior$" },
	float = true,
	center = true,
	size = { 800, 600 },
})

hl.window_rule({
	name = "waydroid-float",
	match = { class = "^waydroid$" },
	float = true,
})

hl.window_rule({
	name = "thunar-rename-float",
	match = {
		class = "^Thunar$",
		title = "^(Rename|Переимен).*$",
	},
	float = true,
	center = true,
	size = { 450, 160 },
})

-- Подключение модуля горячих клавиш
require("keybind")
