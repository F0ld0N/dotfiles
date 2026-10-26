# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load?
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Фича отключения логов при пробеле перед командой
setopt HIST_IGNORE_SPACE

# Мои настройки вывода ls
if command -v eza > /dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -l --icons --git --group-directories-first'
  alias la='eza -a --icons --group-directories-first'
else
  alias ls='ls --color=auto'
  alias ll='ls -lh --group-directories-first'
  alias la='ls -lAh --group-directories-first'
fi

# Дерево на 2 уровня вглубь (оптимально для работы)
alias lt='eza -l --total-size --tree --level=2 --icons --group-directories-first'

# Полное дерево (если нужно увидеть вообще всё)
alias ltt='eza -l --total-size --tree --icons --group-directories-first'

# Вес файлов и директорий в текущей директории
alias sz='du -sh ./* 2>/dev/null | sort -h'
alias sza='du -sh $(ls -A) 2>/dev/null | sort -h'

# Tty-clock fast command
alias clock='tty-clock -cs'

# Alias for compress (resize 50% and 80 quality) files more than 2MB
alias compress='find . -maxdepth 1 -type f \( -name "*.png" -o -name "*.jpg" \) -size +2M -exec ./comp.sh -a {} +'

# Aliases for quick open TUI apps
alias lzg='lazygit'
alias lzd='lazydocker'
alias y='yazi'

# Atuin shell history
if command -v atuin >/dev/null; then
  eval "$(atuin init zsh)"
fi

# User PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="$HOME/.npm-global/bin:$PATH"

# fzf keybindings
if [ -f /usr/share/fzf/key-bindings.zsh ]; then
  source /usr/share/fzf/key-bindings.zsh
fi
