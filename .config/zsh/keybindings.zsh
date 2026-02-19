# Vi mode
bindkey -v
bindkey 'jj' vi-cmd-mode

# History navigation
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
