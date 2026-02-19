# Basic aliases
alias ls='ls -FG'
alias la='ls -laFG'
alias ll='ls -lFG'
alias vi='nvim'
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias vimdiff='nvim -d'

# coreutils overrides (if installed)
if [ -d $(brew --prefix)/opt/coreutils/libexec/gnubin ]; then
    alias ls='ls -F --color=auto'
    alias la='ls -laF --color=auto'
    alias ll='ls -lF --color=auto'
fi
