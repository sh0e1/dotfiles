# .zshrc - Main Zsh configuration
#
# This file sources modular configuration files from ~/.config/zsh/
# Each file is responsible for a specific aspect of the shell environment.

# Configuration directory
ZSHRC_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

# Source configuration files in order
# Note: Order matters - some files depend on variables set by earlier files

# 1. Initialize common variables (brew prefix cache, XDG paths)
source "$ZSHRC_DIR/init.zsh"

# 2. Plugin management (zinit and plugins)
source "$ZSHRC_DIR/plugins.zsh"

# 3. History settings
source "$ZSHRC_DIR/history.zsh"

# 4. Prompt and colors
source "$ZSHRC_DIR/prompt.zsh"

# 5. Completion system
source "$ZSHRC_DIR/completion.zsh"

# 6. Shell options
source "$ZSHRC_DIR/options.zsh"

# 7. Aliases
source "$ZSHRC_DIR/aliases.zsh"

# 8. Key bindings
source "$ZSHRC_DIR/keybindings.zsh"

# 9. FZF and enhancd
source "$ZSHRC_DIR/fzf.zsh"

# 10. Development tools (Go, gcloud, kubectl, GNU tools, etc.)
source "$ZSHRC_DIR/tools.zsh"

# 11. Tmux integration
source "$ZSHRC_DIR/tmux.zsh"

# 12. Custom functions (GitHub CLI, etc.)
source "$ZSHRC_DIR/functions.zsh"

# 13. Optional: Zeno plugin configuration
# [[ -f $ZSHRC_DIR/zeno.zsh ]] && source "$ZSHRC_DIR/zeno.zsh"

# 14. Local machine-specific settings (not committed to git)
[[ -f $ZSHRC_DIR/local.zsh ]] && source "$ZSHRC_DIR/local.zsh"
