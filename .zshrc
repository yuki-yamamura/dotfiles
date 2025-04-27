# base
setopt PROMPT_SUBST
export PROMPT='$ '
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export LANG=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8

# autocomplete
source $(brew --prefix)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh 
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt share_history
setopt hist_ignore_all_dups
stty -ixon

# anyenv
eval "$(anyenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/Users/yuki/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

## pyenv
export PATH="${HOME}/.pyenv/shims:${PATH}"

# Docker Desktop
source /Users/yuki/.docker/init-zsh.sh || true

# GitHub Copilot
eval "$(gh copilot alias -- zsh)"

# paths
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

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

fls() {
  fd -t d | fzf -m | xargs ls -la
}

ftree() {
  fd -t d | fzf -m | xargs tree
}

frm() {
  fzf -m | xargs rm -rf
}

fcode() {
  if [[ "$#" -ne 0 ]]; then
    dir="$(fd -t d | fzf)"
    for file_name in "$@"; do
      full_path="${dir}${file_name}"
      if [[ ! -e "$full_path" ]]; then
        code "$full_path"
      fi
      touch "$full_path" && code "$full_path"
    done
  else
    target="$(fzf)"
    if [[ -d "$target" ]]; then
      code -a $target/**/*
    elif [[ -f "$target" ]]; then
      code "$target"
    fi
  fi
}

fv() {
  nvim $(fzf)
}

fts() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

fghq() {
  local repodir=$(ghq list | fzf -1 +m) && cd $(ghq root)/$repodir
}

fga() {
  git status --short --untracked-files |
    awk '{if (substr($0, 2, 1) != " ") print $2}' |
    fzf -m |
    xargs git add
}


fgs() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git switch $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

fgr() {
  git status --short |
    awk '{if (substr($0, 2, 1) != " ") print $2}' |
    fzf -m |
    xargs git restore --source=HEAD
}
