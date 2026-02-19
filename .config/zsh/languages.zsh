# Go
export GOPATH=$HOME/workspace/gopath
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH:$GOBIN

# Rust
[[ -d $(brew --prefix rustup)/bin ]] && export PATH="$PATH:/opt/homebrew/opt/rustup/bin"

# rbenv
if [ -x $(brew --prefix)/bin/rbenv ]; then
    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
    eval "$(rbenv init -)"
fi

# nvm
if [ -d $HOME/.nvm ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"
    [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"
fi

# pyenv
if [ -x $(brew --prefix)/bin/pyenv ]; then
    export PATH=$(pyenv root)/shims:$PATH
fi

# openjdk
if [ -d $(brew --prefix)/opt/openjdk/bin ]; then
    export PATH="/usr/local/opt/openjdk/bin:$PATH"
fi
