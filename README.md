# 🌌 Arch Linux + Hyprland Dotfiles

Мой персональный сетап для **Arch Linux** и тайлингового оконного менеджера **Hyprland** (на базе современной конфигурации на **Lua**).

Управление конфигурационными файлами реализовано через **GNU Stow**, что позволяет прозрачно создавать симлинки в `$HOME` без засорения системы.

---

## 🖥 Стек компонентов

- **Window Manager**: Hyprland (чистый Lua-конфиг `hyprland.lua` + `keybind.lua`)
- **Idle / Lock / Wallpapers**: `hypridle`, `hyprlock`, `hyprpaper`
- **Bar**: Waybar (модульная панель с кастомными CSS-темами и скриптами)
- **Терминалы**: Ghostty (основной) + Kitty (для всплывающих окон и анимаций)
- **Редактор**: Neovim (LazyVim) & Visual Studio Code
- **Menu / Launcher**: Sherlock & Wofi (с emoji-пикером)
- **Уведомления**: Dunst
- **Файловые менеджеры**: Thunar (GUI) & Yazi (TUI)
- **Мониторинг**: Btop
- **Скриншоты & OCR**: Hyprshot + Tesseract OCR
- **Аудио & Визуализация**: PipeWire, Pavucontrol, Cava
- **Темизация GTK**: Graphite-Dark, Papirus Icons (nwg-look)

---

## 🚀 Быстрый старт на чистой системе

### 1. Клонирование репозитория
```bash
git clone <URL_ТВОЕГО_РЕПОЗИТОРИЯ> ~/dotfiles
cd ~/dotfiles
```

### 2. Запуск автоустановщика
Скрипт интерактивно установит пакеты через `pacman` и `yay`, применит симлинки через `stow`, выдаст права скриптам и включит службы systemd:

```bash
./install.sh
```

---

## 📦 Ручное управление через GNU Stow

Каждая программа вынесена в отдельный модуль. Вы можете применить или удалить симлинки для конкретного компонента в любой момент:

```bash
# Применить все модули:
stow -v -R -t ~ hypr waybar ghostty kitty dunst nvim wofi wlogout btop yazi fastfetch gtk cava mpv code bin git zsh

# Применить только Hyprland:
stow -v -R -t ~ hypr

# Удалить симлинки для модуля:
stow -v -D -t ~ hypr
```

---

## 📂 Структура репозитория

```text
dotfiles/
├── install.sh                  # Единый мастер установки и настройки системы
├── packages-pacman.txt         # Официальные пакеты репозиториев Arch
├── packages-aur.txt            # Пакеты из AUR (yay)
├── vscode-extensions.txt       # Список установленных расширений VS Code
│
├── hypr/                       # Конфиги Hyprland (.config/hypr/)
│   └── .config/hypr/
│       ├── hyprland.lua        # Главный конфиг Hyprland (Lua)
│       ├── keybind.lua         # Горячие клавиши (Lua)
│       ├── hypridle.conf       # Настройки автоблокировки экрана
│       ├── hyprlock.conf       # Экран блокировки
│       ├── hyprpaper.conf      # Обои рабочего стола
│       └── scripts/            # Скрипты (обои, анимации, воркспейсы)
│
├── waybar/                     # Статус-бар (.config/waybar/)
├── ghostty/                    # Конфиг Ghostty (.config/ghostty/)
├── kitty/                      # Конфиг Kitty (.config/kitty/)
├── dunst/                      # Демон уведомлений (.config/dunst/)
├── nvim/                       # LazyVim (.config/nvim/)
├── wofi/                       # Меню запуска и emoji (.config/wofi/)
├── wlogout/                    # Меню выключения (.config/wlogout/)
├── btop/                       # Монитор ресурсов (.config/btop/)
├── yazi/                       # TUI файловый менеджер (.config/yazi/)
├── fastfetch/                  # Инфо о системе (.config/fastfetch/)
├── gtk/                        # GTK-3.0 и nwg-look темы (.config/gtk-3.0/)
├── cava/                       # Аудио-визуализатор (.config/cava/)
├── mpv/                        # Видеоплеер (.config/mpv/)
├── code/                       # Настройки VS Code (settings & keybindings)
├── bin/                        # Пользовательские скрипты (.local/bin/)
├── git/                        # Глобальный конфиг Git (.gitconfig)
└── zsh/                        # Конфиг zsh (.zshrc)
```

---

## 🎨 Обои
Скрипты смены обоев ожидают изображения в директории:
`~/Pictures/Wallpapers/`
Основной фолбек-файл: `~/Pictures/Wallpapers/main.png`.
Смена обоев по хоткею: `SUPER + CTRL + SPACE`.
