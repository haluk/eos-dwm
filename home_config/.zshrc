# Performance optimizations
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

# Cache completions aggressively
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi

export ZSH="$HOME/.oh-my-zsh"

export EDITOR="nvim"
export VISUAL="nvim"

ZSH_COLORIZE_TOOL=pygmentize
ZSH_COLORIZE_STYLE="default"

ZSH_THEME="spaceship"

SPACESHIP_CHAR_SYMBOL="%{$fg[blue]%}λ%b "
SPACESHIP_PROMPT_ORDER=(
  dir
  user
  host
  git
  time
  python
  java
  docker
  venv
  exec_time
  line_sep
  battery
  jobs
  exit_code
  char
)

plugins=(
  colored-man-pages
  colorize
  direnv
  docker
  docker-compose
  extract
  git
  zsh-history-substring-search
  ssh-agent
  pass
  nnn
  zsh-autosuggestions
  zsh-aliases-lsd
  zsh-completions
  zsh-fzf-history-search
  zsh-syntax-highlighting
)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -U compinit && compinit
source "$ZSH/oh-my-zsh.sh"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# Lazy load SSH agent
function _load_ssh_agent() {
    if [ -z "$SSH_AUTH_SOCK" ]; then
        eval "$(ssh-agent -s)" > /dev/null
        ssh-add ~/.ssh/id_ed25519 2>/dev/null
    fi
}
autoload -U add-zsh-hook
add-zsh-hook precmd _load_ssh_agent

export GPG_TTY=$(tty)

export LS_COLORS="$(vivid generate one-dark)"
zstyle ':completion:*:default' list-colors "$LS_COLORS"
export DOCKER_USER="$(id -u):$(id -g)"

export PATH=$PATH:$HOME/.local/bin

# Source aliases
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases

# Source aliases
[ -f ~/.zsh_functions ] && source ~/.zsh_functions

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
