#!/bin/bash

trap 'echo Error: ¥ 0 ($0): stopped; exit 1' ERR INT
set -u
set -e

# A system that judge if this script is necessary or not
if ! type git >/dev/null 2>&1; then
    exit 0
fi

# Testing the judgement system
if [[ -n ${DEBUG:-} ]]; then echo "¥ 0 ($0)" && exit 0; fi

echo -n 'Install NeoBundle? (y/N) '
read
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  curl
  https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
fi
