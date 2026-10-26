#!/usr/bin/env bash
# ==============================================================================
# Dotfiles Installation & Setup Script for Arch Linux + Hyprland
# ==============================================================================

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 1. Проверка дистрибутива
if [ ! -f /etc/arch-release ]; then
    log_warn "Этот скрипт оптимизирован для Arch Linux. Некоторые шаги могут не сработать в других дистрибутивах."
fi

echo -e "${GREEN}"
echo "=========================================================="
echo "    Arch Linux Hyprland Dotfiles Setup (GNU Stow)        "
echo "=========================================================="
echo -e "${NC}"

# 2. Подготовка необходимых директорий
log_info "Создание базовых директорий в домашней папке..."
mkdir -p "$HOME"/.config
mkdir -p "$HOME"/.local/bin
mkdir -p "$HOME"/.cache/config
mkdir -p "$HOME"/Pictures/Wallpapers
mkdir -p "$HOME"/Pictures/screenshots

# Если обоев ещё нет, создадим заглушку или скопируем
if [ ! -f "$HOME"/Pictures/Wallpapers/main.png ]; then
    log_info "Создание placeholder для main.png обоев..."
    touch "$HOME"/Pictures/Wallpapers/main.png
fi

# 3. Выдача прав на исполнение скриптам
log_info "Установка прав на выполнение для скриптов..."
chmod +x "$DOTFILES_DIR"/bin/.local/bin/* 2>/dev/null || true
chmod +x "$DOTFILES_DIR"/hypr/.config/hypr/scripts/* 2>/dev/null || true
chmod +x "$DOTFILES_DIR"/waybar/.config/waybar/scripts/* 2>/dev/null || true
log_success "Права на скрипты обновлены."

# 4. Установка официальных пакетов (Pacman)
read -rp "Установить официальные пакеты из packages-pacman.txt? [y/N]: " install_pacman
if [[ "$install_pacman" =~ ^[Yy]$ ]]; then
    log_info "Обновление баз данных pacman и установка пакетов..."
    if sudo pacman -Syu --needed - < <(grep -vE '^\s*#|^\s*$' "$DOTFILES_DIR/packages-pacman.txt"); then
        log_success "Официальные пакеты установлены."
    else
        log_warn "Некоторые пакеты pacman не удалось установить (или процесс был прерван). Продолжаем работу скрипта..."
    fi
fi

# 5. Проверка и установка AUR Helper (yay)
read -rp "Установить AUR-хелпер (yay) и пакеты из packages-aur.txt? [y/N]: " install_aur
if [[ "$install_aur" =~ ^[Yy]$ ]]; then
    if ! command -v yay &>/dev/null; then
        log_info "yay не найден. Клонирование и сборка yay..."
        sudo pacman -S --needed --noconfirm base-devel git
        TMP_YAY=$(mktemp -d)
        git clone https://aur.archlinux.org/yay.git "$TMP_YAY"
        (cd "$TMP_YAY" && makepkg -si --noconfirm)
        rm -rf "$TMP_YAY"
        log_success "yay успешно установлен!"
    fi

    log_info "Установка пакетов из AUR..."
    if yay -S --needed - < <(grep -vE '^\s*#|^\s*$' "$DOTFILES_DIR/packages-aur.txt"); then
        log_success "AUR пакеты установлены."
    else
        log_warn "Некоторые пакеты из AUR не удалось установить. Продолжаем работу скрипта..."
    fi
fi

# 6. Развертывание конфигов через GNU Stow
read -rp "Применить конфигурации (Stow symlinks в $HOME)? [y/N]: " apply_stow
if [[ "$apply_stow" =~ ^[Yy]$ ]]; then
    if ! command -v stow &>/dev/null; then
        log_warn "GNU Stow не установлен. Устанавливаем..."
        sudo pacman -S --needed --noconfirm stow
    fi

    MODULES=(
        "hypr"
        "waybar"
        "ghostty"
        "kitty"
        "dunst"
        "nvim"
        "wofi"
        "wlogout"
        "btop"
        "yazi"
        "fastfetch"
        "gtk"
        "cava"
        "mpv"
        "code"
        "bin"
        "git"
        "zsh"
    )

    log_info "Создание симлинков с помощью stow..."
    for module in "${MODULES[@]}"; do
        if [ -d "$DOTFILES_DIR/$module" ]; then
            log_info "Применяем модуль: $module"
            stow -v -R -t "$HOME" "$module" 2>/dev/null || {
                log_warn "Конфликт файлов для модуля $module. Применяем с флагом --adopt..."
                stow --adopt -v -R -t "$HOME" "$module"
            }
        fi
    done
    log_success "Все модули успешно привязаны через симлинки."
fi

# 7. Настройка Oh My Zsh, темы Powerlevel10k и плагинов
read -rp "Установить Oh My Zsh, тему Powerlevel10k и плагины (autosuggestions, syntax-highlighting)? [y/N]: " setup_zsh
if [[ "$setup_zsh" =~ ^[Yy]$ ]]; then
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        log_info "Установка Oh My Zsh..."
        RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
    fi

    ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

    if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
        log_info "Клонирование темы powerlevel10k..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k" || true
    fi

    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
        log_info "Клонирование zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" || true
    fi

    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
        log_info "Клонирование zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" || true
    fi
    log_success "Окружение Oh My Zsh и Powerlevel10k готово."
fi

# 7. Установка расширений VS Code
if command -v code &>/dev/null && [ -f "$DOTFILES_DIR/vscode-extensions.txt" ]; then
    read -rp "Установить расширения VS Code из vscode-extensions.txt? [y/N]: " install_code_ext
    if [[ "$install_code_ext" =~ ^[Yy]$ ]]; then
        log_info "Установка расширений VS Code..."
        while IFS= read -r ext || [ -n "$ext" ]; do
            [[ -z "$ext" || "$ext" =~ ^# ]] && continue
            echo "-> Установка $ext..."
            code --install-extension "$ext" --force || true
        done < "$DOTFILES_DIR/vscode-extensions.txt"
        log_success "Расширения VS Code установлены."
    fi
fi

# 8. Включение служб systemd
read -rp "Включить и запустить необходимые службы systemd (NetworkManager, bluetooth, pipewire)? [y/N]: " enable_services
if [[ "$enable_services" =~ ^[Yy]$ ]]; then
    log_info "Настройка служб systemd..."
    sudo systemctl enable --now NetworkManager 2>/dev/null || true
    sudo systemctl enable --now bluetooth 2>/dev/null || true
    systemctl --user enable --now pipewire pipewire-pulse wireplumber 2>/dev/null || true
    log_success "Службы активированы."
fi

# 9. Проверка дефолтного шелла
if [ "$SHELL" != "$(which zsh 2>/dev/null)" ] && command -v zsh &>/dev/null; then
    read -rp "Сделать zsh шеллом по умолчанию? [y/N]: " change_shell
    if [[ "$change_shell" =~ ^[Yy]$ ]]; then
        chsh -s "$(which zsh)"
        log_success "Шелл по умолчанию изменен на zsh."
    fi
fi

echo -e "\n${GREEN}==========================================================${NC}"
echo -e "${GREEN}    Установка и настройка dotfiles успешно завершена!     ${NC}"
echo -e "${GREEN}==========================================================${NC}"
echo -e "Совет: Перезагрузите систему или выполните вход в Hyprland для применения всех настроек.\n"
