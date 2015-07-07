#!/usr/bin/env bash

if [ ! "$(uname -s)" == "Darwin" ]; then
    exit
fi

if test ! $(which tmux)
then
    echo "  Installing tmux for you."
    brew install tmux > /tmp/tmux-install.log
fi
