autoload -Uz compinit
compinit

export PATH="$HOME/.local/bin:$HOME/.config/rofi/scripts:$PATH:$HOME/.cargo/bin:$HOME/bin"

function powerline_precmd() {
    PS1="$(powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" -a -x "$(command -v powerline-shell)" ]; then
    install_powerline_precmd
fi


alias vim='nvim'
alias vimdiff='nvim -d'
export EDITOR='nvim'

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(op completion zsh)"
