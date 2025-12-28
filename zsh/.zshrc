autoload -Uz compinit
compinit

export PATH="$HOME/.local/bin:$HOME/.config/rofi/scripts:$PATH:$HOME/.cargo/bin:$HOME/bin"

alias vim='nvim'
alias vimdiff='nvim -d'
export EDITOR='nvim'

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(op completion zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export TERM="xterm-256color"
