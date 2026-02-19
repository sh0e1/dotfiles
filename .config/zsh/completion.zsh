# Completion settings
zstyle :compinstall filename '$HOME/.zshrc'

fpath=(
  $(brew --prefix)/share/zsh/site-functions
  $fpath
)

# Rust completions
[[ -d $(brew --prefix rustup)/share/zsh/site-functions ]] && fpath+=($(brew --prefix rustup)/share/zsh/site-functions)
[[ -d ~/.rustup/toolchains/stable-aarch64-apple-darwin/share/zsh/site-functions ]] && fpath+=(~/.rustup/toolchains/stable-aarch64-apple-darwin/share/zsh/site-functions)

autoload -Uz compinit && compinit

# https://github.com/b4b4r07/enhancd/issues/172#issuecomment-1492250042
zinit cdreplay -q

# Completion styles
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
zstyle ':completion::complete:*' use-cache true

# Colors
autoload -Uz colors
colors
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors "${LS_COLORS}"
