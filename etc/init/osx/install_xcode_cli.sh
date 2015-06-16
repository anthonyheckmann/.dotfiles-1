#!/bin/bash

trap 'echo Error: $0: stopped; exit 1' ERR
set -e
set -u

# A system that judge if this script is necessary or not
if [[ $OSTYPE != darwin* ]]; then
    exit 0
fi
if type xcode-select >/dev/null 2>&1; then
    exit 0
fi

# Testing the judgement system
if [[ -n ${DEBUG:-} ]]; then echo "$0" && exit 0; fi

# echo -n "Do you install Xcode CLI tools? (y/N) "
# read
# if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  xcode-select --install
  sudo xcodebuild -license
# fi
