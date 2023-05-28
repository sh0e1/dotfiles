#!/bin/bash

set -e

dir=$(
    cd "$(dirname "${BASH_SOURCE:-$0}")"
    pwd
)

# ${dir}/brew.sh
# ${dir}/nvim.sh
# ${dir}/tmux.sh

for f in .??*; do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".config" ]] && continue
    ln -snfv "${dir}/${f}" "${HOME}/${f}"
done

for f in .config/??*; do
    ln -snfv "${dir}/${f}" "${HOME}/${f}"
done

echo "The dotfiles have been copied."
