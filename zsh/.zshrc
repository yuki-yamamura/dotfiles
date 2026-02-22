# base
setopt PROMPT_SUBST
export PROMPT='$ '
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export LANG=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8

# aliases
alias g=git
alias v=nvim
alias y=yazi
alias dc="docker compose"
alias dcu="docker compose up"
alias dcd="docker compose down"
alias ccr="npx @sasazame/ccresume@latest"
alias ccu="npx ccusage@latest"
alias ld="lazydocker"
alias lg="lazygit"

# autocomplete
source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt share_history
setopt hist_ignore_all_dups
stty -ixon

# mise
eval "$(mise activate zsh)"

# paths
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--no-height --extended --exact'
export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git --exclude node_modules --exclude .next'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

function select-history() {
  BUFFER=$(history -n -r 1 | fzf --reverse --query="$LBUFFER" --prompt="History > ")
  CURSOR=${#BUFFER}
}
zle -N select-history
bindkey '^R' select-history

# shorthands
fcd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -path '*/node_modules/*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

frm() {
  fzf -m | xargs rm -rf
}

fv() {
  nvim $(fzf)
}

fghq() {
  local repodir=$(ghq list | fzf -1 +m) && cd $(ghq root)/$repodir
}

