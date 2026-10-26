#!/usr/bin/env bash

# Путь к папке и файлу состояния
DIR="$HOME/Pictures/Wallpapers"
STATE="$HOME/.cache/current_wallpaper"

# Получаем список файлов обоев
mapfile -t LIST < <(find "$DIR" -type f | sort)

# Если папка пуста, выходим
[[ ${#LIST[@]} -eq 0 ]] && exit 1

# Находим текущие обои и выбираем следующие
LAST=$(cat "$STATE" 2>/dev/null)
NEXT_INDEX=0

for i in "${!LIST[@]}"; do
  if [[ "${LIST[$i]}" == "$LAST" ]]; then
    NEXT_INDEX=$(((i + 1) % ${#LIST[@]}))
    break
  fi
done

WALLPAPER="${LIST[$NEXT_INDEX]}"

# 1. Получаем список только ТЕКУЩИХ АКТИВНЫХ мониторов из hyprctl
# Утилита aq (или jq) здесь не нужна, парсим чистый текст от hyprctl
ACTIVE_MONITORS=$(hyprctl monitors | grep "Monitor" | awk '{print $2}')

# 2. Перебираем все активные мониторы и меняем на них обои на лету
for MONITOR in $ACTIVE_MONITORS; do
  hyprctl hyprpaper wallpaper "$MONITOR,$WALLPAPER"
done

# Сохраняем выбранные обои для следующего раза
echo "$WALLPAPER" >"$STATE"
