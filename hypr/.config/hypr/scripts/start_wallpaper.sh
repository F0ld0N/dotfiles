#!/usr/bin/env bash

# Пути
STATE="$HOME/.cache/current_wallpaper"
CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"

# Список ВСЕХ ваших мониторов
MONITORS=("eDP-1" "DP-1" "HDMI-A-1")

# 1. Читаем путь из кэша
if [ -f "$STATE" ]; then
  WALLPAPER=$(cat "$STATE")
else
  # Фолбек, если кэш пуст
  WALLPAPER="$HOME/Pictures/Wallpapers/main.png"
fi

# 2. Начало формирования hyprpaper.conf
cat <<EOF >"$CONFIG_FILE"
# Автоматически сгенерировано стартовым скриптом
splash = false
EOF

# 3. Динамически добавляем блок wallpaper для каждого монитора из списка
for MONITOR in "${MONITORS[@]}"; do
  cat <<EOF >>"$CONFIG_FILE"

wallpaper {
    monitor = $MONITOR
    path = $WALLPAPER
}
EOF
done

# 4. Перезапускаем hyprpaper
pkill hyprpaper
# Даем полсекунды на корректное закрытие, чтобы порт освободился
sleep 0.5
hyprpaper &
