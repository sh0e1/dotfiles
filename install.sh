#!/bin/bash

set -e

dir=$(
    cd "$(dirname "${BASH_SOURCE:-$0}")"
    pwd
)

# ${dir}/brew.sh

for f in .??*; do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".config" ]] && continue
    [[ "$f" == ".claude" ]] && continue
    ln -snfv "${dir}/${f}" "${HOME}/${f}"
done

# Handle .config directory
XDG_CONFIG_HOME="$HOME/.config"
if [ ! -d "$XDG_CONFIG_HOME" ]; then
    mkdir "$XDG_CONFIG_HOME"
    echo "Created $XDG_CONFIG_HOME directory."
fi

for f in .config/*; do
    [ -e "$f" ] || continue
    ln -snfv "${dir}/${f}" "${HOME}/${f}"
done

# Handle .claude directory
CLAUDE_DIR="$HOME/.claude"
if [ ! -d "$CLAUDE_DIR" ]; then
    mkdir "$CLAUDE_DIR"
    echo "Created $CLAUDE_DIR directory."
fi

for f in .claude/*; do
    [ -e "$f" ] || continue
    ln -snfv "${dir}/${f}" "${HOME}/${f}"
done

# Remove broken symlinks left behind by files deleted from the repo
cleanup_broken_symlinks() {
    local target_dir="$1"
    [ -d "$target_dir" ] || return 0
    while IFS= read -r -d '' link; do
        local link_target
        link_target=$(readlink "$link")
        case "$link_target" in
            "${dir}"/*|"${dir}")
                rm -v "$link"
                ;;
        esac
    done < <(find "$target_dir" -maxdepth 1 -type l ! -exec test -e {} \; -print0 2>/dev/null)
}

cleanup_broken_symlinks "$HOME"
cleanup_broken_symlinks "$XDG_CONFIG_HOME"
cleanup_broken_symlinks "$CLAUDE_DIR"

echo "The dotfiles have been copied."
