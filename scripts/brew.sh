#!/bin/bash

set -e

dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew bundle --file=${dir}/../Brewfile

# Install Ricty
cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
fc-cache -vf
