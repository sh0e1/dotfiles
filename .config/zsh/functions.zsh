# tmux auto-attach on login shell
if [[ ! -n $TMUX && $- == *l* ]]; then
    ID="`tmux list-sessions`"
    if [[ -z "$ID" ]]; then
        tmux new-session
    fi
    create_new_session="Create New Session"
    ID="$ID\n${create_new_session}:"
    ID="`echo $ID | fzf | cut -d: -f1`"
    if [[ "$ID" = "${create_new_session}" ]]; then
        tmux new-session
    elif [[ -n "$ID" ]]; then
        tmux attach-session -t "$ID"
    else
        :  # Start terminal normally
    fi
fi

# tmux session list
_tmux_list_sessions() {
    out=$(tmux list-sessions | fzf-tmux -d 50%)
    [[ -z $out ]] && return
    sid=$(echo $out | cut -d: -f1)
    tmux switch -t $sid
}
alias tmls='_tmux_list_sessions'

# tmux window list
_tmux_list_windows() {
    out=$(tmux list-windows | fzf-tmux -d 50%)
    [[ -z $out ]] && return
    wid=$(echo $out | cut -d: -f1)
    tmux select-window -t $wid
}
alias tmlw='_tmux_list_windows'

# GitHub CLI: issue browser
gh::issue() {
    out=$(gh issue list --limit 100 | fzf-tmux -d 50% --preview="gh issue view {1}")
    [[ -z $out ]] && return
    issue=$(echo $out | awk '{print $1}')
    gh issue view $issue --web
}
alias ghi='gh::issue'

# GitHub CLI: PR browser
gh::pr() {
    out=$(gh pr list --limit 100 | fzf-tmux -d 50% --preview="gh pr view {1}" --expect=ctrl-o)
    [[ -z $out ]] && return
    outs=(${(@f)out})
    if [[ $outs[1] == 'ctrl-o' ]]; then
        pr=$(echo $outs[2] | awk '{print $1}')
        gh pr checkout $pr
    else
        pr=$(echo $outs[1] | awk '{print $1}')
        gh pr view $pr --web
    fi
}
alias ghp='gh::pr'
