export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'zsh-users/zsh-history-substring-search'
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
# zplug 'tcnksm/docker-alias', use:zshrc
zplug 'plugins/docker', from:oh-my-zsh
# zplug 'plugins/git', from:oh-my-zsh
zplug 'b4b4r07/enhancd', use:init.sh
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
zplug 'wfxr/forgit'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=100000
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
autoload -Uz compinit
compinit
# End of lines added by compinstall

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
zstyle ':completion::complete:*' use-cache true

# lang
export LANG=ja_JP.UTF-8

# color
autoload -Uz colors
colors
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors "${LS_COLORS}"

# options
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt hist_ignore_all_dups
setopt no_beep
setopt interactive_comments
setopt ignore_eof
setopt hist_reduce_blanks
setopt print_eight_bit
setopt no_flow_control
setopt extended_glob
setopt extended_history
setopt hist_verify
setopt hist_save_no_dups
setopt hist_no_store
setopt hist_expand
setopt inc_append_history

# alias
alias lst='ls -ltrFG'
alias ls='ls -FG'
alias la='ls -laFG'
alias ll='ls -lFG'
alias vi='nvim'
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias vimdiff='nvim -d'

# key bind
bindkey -v
bindkey 'jj' vi-cmd-mode
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_TMUX=1
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS="--reverse --inline-info"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always {} | head -500'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
bindkey '^D' fzf-cd-widget

# Go
export GOPATH=$HOME/workspace/gopath
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH:$GOBIN

# google-cloud-sdk
export CLOUDSDK_PYTHON="/usr/local/opt/python@3.8/libexec/bin/python"
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# krew
if [ -d ${HOME}/.krew/bin ]; then
    export PATH="${PATH}:${HOME}/.krew/bin"
fi

# direnv
export EDITOR=nvim
eval "$(direnv hook zsh)"

# tmux
if [[ ! -n $TMUX && $- == *l* ]]; then
    # get the IDs
    ID="`tmux list-sessions`"
    if [[ -z "$ID" ]]; then
        tmux new-session
    fi
    create_new_session="Create New Session"
    ID="$ID\n${create_new_session}:"
    ID="`echo $ID | fzf | cut -d: -f1`"
    if [[ "$ID" = "${create_new_session}" ]]; then
        tmux new-session
    elif [[ -n "$ID" ]]; then
        tmux attach-session -t "$ID"
    else
        :  # Start terminal normally
    fi
fi

tmls() {
  out=$(tmux list-sessions | fzf)
  [[ -z $out ]] && return
  sid=$(echo $out | cut -d: -f1)
  tmux switch -t $sid
}

tmlw() {
  out=$(tmux list-windows | fzf)
  [[ -z $out ]] && return
  wid=$(echo $out | cut -d: -f1)
  tmux select-window -t $wid
}

# openjdk
if [ -d /usr/local/opt/openjdk/bin ]; then
    export PATH="/usr/local/opt/openjdk/bin:$PATH"
fi

# Rust
if [ -d $HOME/.cargo ]; then
    export PATH="$PATH:$HOME/.cargo/bin"
    source $HOME/.cargo/env
fi

# rbenv
if [ -e /usr/local/bin/rbenv ]; then
    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
    eval "$(rbenv init -)"
fi

# spaceship-prompt
SPACESHIP_PROMPT_ORDER=(
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  char          # Prompt character
)
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_CHAR_SYMBOL='> '
SPACESHIP_CHAR_COLOR_SUCCESS=white
SPACESHIP_DIR_COLOR=blue
SPACESHIP_GIT_PREFIX='git:'
SPACESHIP_GIT_BRANCH_PREFIX='('
SPACESHIP_GIT_BRANCH_SUFFIX=')'
SPACESHIP_GIT_BRANCH_COLOR=cyan
SPACESHIP_GIT_STATUS_PREFIX=''
SPACESHIP_GIT_STATUS_SUFFIX=''

_fzf_alias() {
  selected=$(alias | fzf --height=40 | awk -F "=" '{print $1}' | sed -e "s/'//g")
  if [ -n $selected ]; then
    BUFFER=$selected
    CURSOR=${#BUFFER}
  fi
  zle redisplay
}
zle -N _fzf_alias
bindkey '^A' _fzf_alias

# gh
gh::issue() {
  out=$(gh issue list --limit 100 | fzf --preview="gh issue view {1}")
  [[ -z $out ]] && return
  issue=$(echo $out | awk '{print $1}')
  gh issue view $issue --web
}
alias ghi='gh::issue'

gh::pr() {
  out=$(gh pr list --limit 100 | fzf --preview="gh pr view {1}" --expect=ctrl-o)
  [[ -z $out ]] && return
  outs=(${(@f)out})
  if [[ $outs[1] == 'ctrl-o' ]]; then
    pr=$(echo $outs[2] | awk '{print $1}')
    gh pr checkout $pr
  else
    pr=$(echo $outs[1] | awk '{print $1}')
    gh pr view $pr --web
  fi
}
alias ghp='gh::pr'
