# tools.zsh - Development tools configuration

# Go
export GOPATH=$HOME/workspace/gopath
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH:$GOBIN

# Google Cloud SDK
if [[ -n $BREW_PREFIX && -e $BREW_PREFIX/bin/gcloud ]]; then
    source "$BREW_PREFIX/share/google-cloud-sdk/path.zsh.inc"
    source "$BREW_PREFIX/share/google-cloud-sdk/completion.zsh.inc"
fi

# kubectl
(( $+commands[kubectl] )) && source <(kubectl completion zsh)

# krew
[[ -d ${HOME}/.krew/bin ]] && export PATH="${PATH}:${HOME}/.krew/bin"

# GNU tools (prefer over BSD variants)
if [[ -n $BREW_PREFIX ]]; then
    # gnu-sed
    [[ -d $BREW_PREFIX/opt/gnu-sed/libexec/gnubin ]] && \
        export PATH="$BREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"

    # gawk
    [[ -d $BREW_PREFIX/opt/gawk/libexec/gnubin ]] && \
        export PATH="$BREW_PREFIX/opt/gawk/libexec/gnubin:$PATH"

    # coreutils
    if [[ -d $BREW_PREFIX/opt/coreutils/libexec/gnubin ]]; then
        export PATH="$BREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
        # Override ls aliases with GNU ls colors
        alias ls='ls -F --color=auto'
        alias la='ls -laF --color=auto'
        alias ll='ls -lF --color=auto'
    fi
fi

# direnv
[[ -n $BREW_PREFIX && -x $BREW_PREFIX/bin/direnv ]] && eval "$(direnv hook zsh)"

# openjdk
[[ -n $BREW_PREFIX && -d $BREW_PREFIX/opt/openjdk/bin ]] && \
    export PATH="$BREW_PREFIX/opt/openjdk/bin:$PATH"

# Rust
[[ -n $BREW_PREFIX && -d $BREW_PREFIX/opt/rustup/bin ]] && \
    export PATH="$PATH:$BREW_PREFIX/opt/rustup/bin"

# rbenv
if [[ -n $BREW_PREFIX && -x $BREW_PREFIX/bin/rbenv ]]; then
    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$BREW_PREFIX/opt/openssl@1.1"
    eval "$(rbenv init -)"
fi

# nvm
if [[ -d $HOME/.nvm ]]; then
    export NVM_DIR="$HOME/.nvm"
    [[ -n $BREW_PREFIX && -s $BREW_PREFIX/opt/nvm/nvm.sh ]] && \. "$BREW_PREFIX/opt/nvm/nvm.sh"
    [[ -n $BREW_PREFIX && -s $BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm ]] && \. "$BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"
fi

# pyenv
[[ -n $BREW_PREFIX && -x $BREW_PREFIX/bin/pyenv ]] && \
    export PATH=$(pyenv root)/shims:$PATH

# XDG bin directory
[[ -d $XDG_BIN_HOME ]] && export PATH="$XDG_BIN_HOME:$PATH"
