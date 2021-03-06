#!/bin/bash

set -e

dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ${dir}/installer.sh
sh ${dir}/installer.sh ~/.cache/dein
pip3 install --user pynvim
rm -f ${dir}/installer.sh

# textlint
npm install -g textlint
npm install -g textlint-rule-preset-ja-technical-writing
go get github.com/mattn/efm-langserver
