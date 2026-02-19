# completion.zsh - Completion system configuration

zstyle :compinstall filename '$HOME/.zshrc'

# Setup fpath for completions
fpath=($fpath)
[[ -n $BREW_PREFIX ]] && fpath=($BREW_PREFIX/share/zsh/site-functions $fpath)
[[ -d ${BREW_PREFIX:-}/opt/rustup/share/zsh/site-functions ]] && fpath+=($BREW_PREFIX/opt/rustup/share/zsh/site-functions)
[[ -d ~/.rustup/toolchains/stable-aarch64-apple-darwin/share/zsh/site-functions ]] && fpath+=(~/.rustup/toolchains/stable-aarch64-apple-darwin/share/zsh/site-functions)

# Initialize completion system
autoload -Uz compinit && compinit

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # Case-insensitive matching
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*' list-colors "${LS_COLORS}"
