local mainMod = "SUPER"

local terminal = _G.terminal
local fileManager = _G.fileManager
local menu = _G.menu
local browser = _G.browser

-- =============================================================================
-- СИСТЕМНЫЕ УПРАВЛЕНИЯ И ЯРКОСТЬ
-- =============================================================================
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })

hl.bind(
	mainMod .. " + escape",
	hl.dsp.exec_cmd('kitty --class="hyprland-floating-center" -e ~/.config/waybar/scripts/power')
)
hl.bind(
	mainMod .. " + tab",
	hl.dsp.exec_cmd('kitty --class="hyprland-floating-center" -e ~/.config/hypr/scripts/changeWorkspace')
)
hl.bind(mainMod .. " + CTRL + space", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallchange.sh"))

-- Перемещение позиций окон в тайлинге
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "r" }))

hl.bind("ALT + Tab", hl.dsp.focus({ workspace = "previous" }))

-- Изменение размеров и полноэкранный режим
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + L", hl.dsp.window.resize({ x = 70, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + H", hl.dsp.window.resize({ x = -70, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + K", hl.dsp.window.resize({ x = 0, y = -70, relative = true }), { repeating = true })
hl.bind(mainMod .. " + J", hl.dsp.window.resize({ x = 0, y = 70, relative = true }), { repeating = true })

-- Быстрый запуск приложений
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(terminal .. " -e btop"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("code"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("AyuGram"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("obsidian"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(terminal .. " -e lazydocker"))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd("keepassxc"))

-- small features
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd(terminal .. " -e termusic"))
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.exec_cmd("killall waybar &"))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("waybar &"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("killall waybar && waybar --log-level error &"))
hl.bind(mainMod .. " + SHIFT + Y", hl.dsp.exec_cmd("hyprsunset -t 5000 &"))
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.exec_cmd("killall hyprsunset &"))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd("hyprpicker -a -f hex &"))

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("wl-copy q"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("~/.config/hypr/scripts/wofi-emoji"))

-- Скриншоты и захват экрана
hl.bind(
	"PRINT",
	hl.dsp.exec_cmd([[hyprshot -m region -o ~/Pictures/screenshots/ -f "screenshot_$(date +'%Y%m%d_%H%M%S').png" -c]])
)
hl.bind(
	"SHIFT + PRINT",
	hl.dsp.exec_cmd(
		[[hyprshot -m output -m eDP-1 -o ~/Pictures/screenshots/ -f "screenshot_$(date +'%Y%m%d_%H%M%S').png" -c]]
	)
)
hl.bind("ALT + PRINT", hl.dsp.exec_cmd("hyprshot -m window -m active --clipboard-only"))
hl.bind(
	"CTRL + PRINT",
	hl.dsp.exec_cmd(
		[[hyprshot -m region -o ~/Pictures/screenshots/ -f "screenshot_$(date +'%Y%m%d_%H%M%S').png" -c --clipboard-only]]
	)
)
hl.bind("CTRL + SHIFT + PRINT", hl.dsp.exec_cmd([[hyprshot -m region --raw | tesseract - stdout -l rus+eng | wl-copy]]))

-- Основное управление окнами
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd(terminal .. " -e yazi"))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + G", hl.dsp.layout("togglesplit"))

-- Навигация фокуса (стрелки)
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Управление рабочими областями (1-10)
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Специальная рабочая область (Scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Привязки мыши
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Мультимедиа клавиши
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
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
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Дополнительные скрипты синхронизации
hl.bind(
	mainMod .. " + SHIFT + C",
	hl.dsp.exec_cmd('kitty --class="hyprland-floating-center" -e ~/.config/hypr/scripts/sync')
)
hl.bind(
	mainMod .. " + SHIFT + G",
	hl.dsp.exec_cmd('kitty --class="hyprland-floating-center" -e ~/.config/hypr/scripts/cloud')
)
