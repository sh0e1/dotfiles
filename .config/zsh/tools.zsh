# google-cloud-sdk
if [ -e $(brew --prefix)/bin/gcloud ]; then
    source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
    source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
fi

# kubectl
if [ $commands[kubectl] ]; then
    source <(kubectl completion zsh)
fi

# krew
if [ -d ${HOME}/.krew/bin ]; then
    export PATH="${PATH}:${HOME}/.krew/bin"
fi

# gnu-sed
if [ -d $(brew --prefix)/opt/gnu-sed/libexec/gnubin ]; then
    export PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"
fi

# gawk
if [ -d $(brew --prefix)/opt/gawk/libexec/gnubin ]; then
    export PATH="$(brew --prefix)/opt/gawk/libexec/gnubin:$PATH"
fi

# coreutils
if [ -d $(brew --prefix)/opt/coreutils/libexec/gnubin ]; then
    export PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
fi

# direnv
if [ -x $(brew --prefix)/bin/direnv ]; then
    eval "$(direnv hook zsh)"
fi

# $XDG_BIN_HOME
if [ -d $XDG_BIN_HOME ]; then
    export PATH="$XDG_BIN_HOME:$PATH"
fi
