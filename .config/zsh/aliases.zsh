# aliases.zsh - Command aliases

# ls aliases (will be overridden by GNU coreutils if available)
alias ls='ls -FG'
alias la='ls -laFG'
alias ll='ls -lFG'

# Editor
alias vi='nvim'
alias vimdiff='nvim -d'

# Safe file operations
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
