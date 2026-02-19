# functions.zsh - Custom shell functions

# GitHub CLI integration

# Browse and open GitHub issues with fzf
ghi() {
    local out issue
    out=$(gh issue list --limit 100 | fzf-tmux -d 50% --preview="gh issue view {1}")
    [[ -z $out ]] && return
    issue=$(echo $out | awk '{print $1}')
    gh issue view $issue --web
}

# Browse GitHub PRs with fzf (Ctrl-O to checkout)
ghp() {
    local out outs pr
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
