# history.zsh - History configuration

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=100000

# History options
setopt hist_ignore_all_dups  # Remove older duplicate entries
setopt hist_reduce_blanks    # Remove superfluous blanks
setopt hist_save_no_dups     # Don't save duplicates
setopt hist_no_store         # Don't store history command
setopt hist_expand           # Expand history on completion
setopt hist_verify           # Show expanded history before executing
setopt extended_history      # Save timestamp and duration
setopt inc_append_history    # Add commands immediately
setopt share_history         # Share history between sessions
