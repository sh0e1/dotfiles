# prompt.zsh - Prompt and color configuration

# Initialize colors
autoload -Uz colors && colors

# LS colors
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# Git prompt configuration
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUPSTREAM='auto'
GIT_PS1_STATESEPARATOR='|'
GIT_PS1_COMPRESSSPARSESTATE=1
GIT_PS1_SHOWCONFLICTSTATE='yes'
GIT_PS1_DESCRIBE_STYLE='default'
GIT_PS1_SHOWCOLORHINTS=1

# Prompt
setopt PROMPT_SUBST
PS1='%F{blue}%2c%f $(__git_ps1 "git:(%s)") > '
