# options.zsh - Shell options

# Directory navigation
setopt auto_cd              # cd by typing directory name
setopt auto_pushd           # Push directories to stack
setopt pushd_ignore_dups    # Don't push duplicates

# Input/Output
setopt no_beep              # No beep on error
setopt interactive_comments # Allow comments in interactive shell
setopt ignore_eof           # Don't exit on Ctrl-D
setopt print_eight_bit      # Print 8-bit characters
setopt no_flow_control      # Disable Ctrl-S/Ctrl-Q flow control

# Globbing
setopt extended_glob        # Extended glob patterns
