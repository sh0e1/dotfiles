# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice pick"init.sh"
zinit light b4b4r07/enhancd
zinit ice pick"contrib/completion/git-prompt.sh"
zinit light git/git
#zinit ice lucid depth"1" blockf
#zinit light yuki-yano/zeno.zsh
zinit ice as"completion"
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

# Apply fast-syntax-highlighting theme overlay
# https://github.com/zdharma-continuum/fast-syntax-highlighting/blob/master/THEME_GUIDE.md
fast-theme XDG:overlay 1>/dev/null

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=100000

# completion
zstyle :compinstall filename '$HOME/.zshrc'
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
zstyle ':completion::complete:*' use-cache true

# color
autoload -Uz colors
colors
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors "${LS_COLORS}"

# prompt
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUPSTREAM='auto'
GIT_PS1_STATESEPARATOR='|'
GIT_PS1_COMPRESSSPARSESTATE=1
GIT_PS1_SHOWCONFLICTSTATE='yes'
GIT_PS1_DESCRIBE_STYLE='default'
GIT_PS1_SHOWCOLORHINTS=1
setopt PROMPT_SUBST ; PS1='%F{blue}%2c%f% $(__git_ps1 " git:(%s)") > '

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
setopt share_history

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
alias sed='gsed'

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
export FZF_TMUX_HEIGHT=50%
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS="--layout=reverse --info=inline"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS="
    --preview 'bat -n --color=always {}'
    --bind '?:change-preview-window(down|hidden|)'"
export FZF_CTRL_R_OPTS="
    --preview 'echo {}' --preview-window up:3:hidden:wrap
    --bind '?:toggle-preview'
    --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
    --color header:italic
    --header 'Press CTRL-Y to copy command into clipboard'"
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
bindkey '^D' fzf-cd-widget

# Go
export GOPATH=$HOME/workspace/gopath
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH:$GOBIN

# google-cloud-sdk
if [ -e $(brew --prefix)/bin/gcloud ]; then
    source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
    source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
fi

if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# krew
if [ -d ${HOME}/.krew/bin ]; then
    export PATH="${PATH}:${HOME}/.krew/bin"
fi

# direnv
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
  out=$(tmux list-sessions | fzf-tmux -d 50%)
  [[ -z $out ]] && return
  sid=$(echo $out | cut -d: -f1)
  tmux switch -t $sid
}

tmlw() {
  out=$(tmux list-windows | fzf-tmux -d 50%)
  [[ -z $out ]] && return
  wid=$(echo $out | cut -d: -f1)
  tmux select-window -t $wid
}

# openjdk
if [ -d $(brew --prefix)/opt/openjdk/bin ]; then
    export PATH="/usr/local/opt/openjdk/bin:$PATH"
fi

# Rust
if [ -d $HOME/.cargo ]; then
    export PATH="$PATH:$HOME/.cargo/bin"
    source $HOME/.cargo/env
fi

# rbenv
if [ -e $(brew --prefix)/bin/rbenv ]; then
    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
    eval "$(rbenv init -)"
fi

# nvm
if [ -d $HOME/.nvm ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
fi

# pyenv
if [ -e $(brew --prefix)/bin/pyenv ]; then
    export PATH=$(pyenv root)/shims:$PATH
fi

_fzf_alias() {
  selected=$(alias | fzf-tmux -d 50% | awk -F "=" '{print $1}' | sed -e "s/'//g")
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
  out=$(gh issue list --limit 100 | fzf-tmux -d 50% --preview="gh issue view {1}")
  [[ -z $out ]] && return
  issue=$(echo $out | awk '{print $1}')
  gh issue view $issue --web
}
alias ghi='gh::issue'

gh::pr() {
  out=$(gh pr list --limit 100 | fzf-tmux -d 50% --preview="gh pr view {1}" --expect=ctrl-o)
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

# Load split zsh files
#[ -f $XDG_CONFIG_HOME/zsh/zeno.zsh ]  && source $XDG_CONFIG_HOME/zsh/zeno.zsh
[ -f $XDG_CONFIG_HOME/zsh/local.zsh ] && source $XDG_CONFIG_HOME/zsh/local.zsh
