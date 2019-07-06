#!/bin/bash
set -e

DOT_DIRECTORY=`pwd`

for f in .??*
do
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".DS_Store" ]] && continue
  [[ "$f" == ".gitignore" ]] && continue

  ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
done

go get -u github.com/sourcegraph/go-langserver

echo "Install dotfiles complate."

