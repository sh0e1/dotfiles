# zshrc - Main configuration file
# Split configurations are loaded from $XDG_CONFIG_HOME/zsh/

ZSH_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

# Load split configuration files in order
source "$ZSH_CONFIG_DIR/plugins.zsh"     # zinit and plugins
source "$ZSH_CONFIG_DIR/options.zsh"     # shell options and history
source "$ZSH_CONFIG_DIR/completion.zsh"  # completion settings
source "$ZSH_CONFIG_DIR/prompt.zsh"      # prompt settings
source "$ZSH_CONFIG_DIR/aliases.zsh"     # aliases
source "$ZSH_CONFIG_DIR/keybindings.zsh" # key bindings
source "$ZSH_CONFIG_DIR/fzf.zsh"         # fzf settings
source "$ZSH_CONFIG_DIR/tools.zsh"       # tool configurations
source "$ZSH_CONFIG_DIR/languages.zsh"   # language version managers
source "$ZSH_CONFIG_DIR/functions.zsh"   # custom functions

# Load local configurations (machine-specific, not version controlled)
[ -f "$ZSH_CONFIG_DIR/local.zsh" ] && source "$ZSH_CONFIG_DIR/local.zsh"
