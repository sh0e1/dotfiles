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
    ln -snfv "${dir}/${f}" "${HOME}/${f}"
done

XDG_CONFIG_HOME="$HOME/.config"
if [ ! -d "$XDG_CONFIG_HOME" ]; then
    mkdir "$XDG_CONFIG_HOME"
    echo "Created $XDG_CONFIG_HOME directory."
fi

for f in .config/??*; do
    ln -snfv "${dir}/${f}" "${HOME}/${f}"
done

echo "The dotfiles have been copied."
