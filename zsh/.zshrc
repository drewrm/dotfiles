autoload -Uz compinit
compinit

bindkey -v
bindkey ^R history-incremental-search-backward 
bindkey ^S history-incremental-search-forward
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

export PATH="${HOME}/.local/bin:${HOME}/bin:${PATH}"

alias vim='nvim'
alias vimdiff='nvim -d'
export EDITOR='nvim'

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(op completion zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ${HOME}/.cargo/env


export TERM="xterm-256color"

HISTSIZE=2000
HISTFILE=~/.cache/zsh/history
SAVEHIST=${HISTSIZE}
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select

alias ls='ls --color'
export FZF_DEFAULT_OPTS='--color=fg:#a9b1d6,fg+:#414868,bg:#15161e,bg+:#bb9af7
  --color=hl:#bb9af7,hl+:#bb9af7,info:#9ece6a,marker:#9ece6a,gutter:#414868
  --color=prompt:#7aa2f7,spinner:#bb9af7,pointer:#bb9af7,header:#9ece6a
  --color=border:#7aa2f7,label:#aeaeae,query:#d9d9d9
  --preview-window="border-rounded" --prompt="> " --marker="" --pointer=""
  --separator=" " --scrollbar="║" --border="rounded" --margin=1 --padding=1'
