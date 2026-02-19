# tmux.zsh - Tmux integration

# Auto-attach to tmux session on login shell
if [[ ! -n $TMUX && $- == *l* ]]; then
    ID=$(tmux list-sessions 2>/dev/null)
    if [[ -z "$ID" ]]; then
        tmux new-session
    else
        create_new_session="Create New Session"
        ID="$ID\n${create_new_session}:"
        ID=$(echo $ID | fzf | cut -d: -f1)
        if [[ "$ID" = "${create_new_session}" ]]; then
            tmux new-session
        elif [[ -n "$ID" ]]; then
            tmux attach-session -t "$ID"
        fi
        # If no selection, start terminal normally
    fi
fi

# Tmux session switcher
tmls() {
    local out sid
    out=$(tmux list-sessions | fzf-tmux -d 50%)
    [[ -z $out ]] && return
    sid=$(echo $out | cut -d: -f1)
    tmux switch -t $sid
}

# Tmux window switcher
tmlw() {
    local out wid
    out=$(tmux list-windows | fzf-tmux -d 50%)
    [[ -z $out ]] && return
    wid=$(echo $out | cut -d: -f1)
    tmux select-window -t $wid
}
