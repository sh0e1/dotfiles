export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'zsh-users/zsh-history-substring-search'
zplug 'tcnksm/docker-alias', use:zshrc
zplug 'plugins/git', from:oh-my-zsh
zplug 'modules/prompt', from:prezto
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=100000
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
autoload -Uz compinit
compinit -u
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
alias c='cdr'
alias cp='cp -i'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias vimdiff='nvim -d'

# key bind
bindkey -v
bindkey 'jj' vi-cmd-mode
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

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
export EDITOR=vim
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

# vcs
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

# prompt
PROMPT='%c > '
RPROMPT='${vcs_info_msg_0_}'

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
