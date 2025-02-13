#!/bin/bash

set -e

dir=$(
    cd "$(dirname "${BASH_SOURCE:-$0}")"
    pwd
)

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "Homebrew has been installed."

echo "Installing Homebrew packages..."
brew bundle --file="${dir}/../Brewfile"
echo "Homebrew packages have been installed."
