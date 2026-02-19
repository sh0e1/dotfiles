# init.zsh - Early initialization and cached variables
# This file should be sourced first to set up common variables

# Cache brew prefix to avoid repeated calls (significant performance improvement)
if (( $+commands[brew] )); then
    export BREW_PREFIX="${BREW_PREFIX:-$(brew --prefix)}"
fi

# XDG Base Directory Specification
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"

# Zsh config directory
export ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"
