# fzf.zsh - FZF and enhancd configuration

# Load fzf
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# FZF settings
export FZF_TMUX=1
export FZF_TMUX_HEIGHT=50%
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS="--layout=reverse --info=inline"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS="
    --preview 'bat -n --color=always {}'
    --bind '?:change-preview-window(down|hidden|)'"
export FZF_CTRL_R_OPTS="
    --preview 'echo {}' --preview-window up:3:hidden:wrap
    --bind '?:toggle-preview'
    --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
    --color header:italic
    --header 'Press CTRL-Y to copy command into clipboard'"
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

# Bind Ctrl+D to fzf-cd-widget
bindkey '^D' fzf-cd-widget

# enhancd settings
export ENHANCD_FILTER="fzf-tmux -d 50% --preview 'tree -C {}'"

# FZF alias selector widget
_fzf_alias() {
    local selected
    selected=$(alias | fzf-tmux -d 50% | awk -F "=" '{print $1}' | sed -e "s/'//g")
    if [[ -n $selected ]]; then
        BUFFER=$selected
        CURSOR=${#BUFFER}
    fi
    zle redisplay
}
zle -N _fzf_alias
bindkey '^A' _fzf_alias
