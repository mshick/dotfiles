#!/usr/bin/env bash

# source "$DOTFILES_ROOT/node/zsh-nvm.plugin.zsh"

# if ! [ -x "$(command -v node)" ]
# then
#     echo "  Installing node.js with nvm for you."
#     export NVM_DIR="$HOME/.nvm"
#     . "$(brew --prefix nvm)/nvm.sh"
#     nvm install stable
# fi

if test ! $(which spoof)
then
    echo "  Installing spoof for you."
    npm install spoof --global > /tmp/spoof-install.log
fi

if test ! $(which name-that-color)
then
    echo "  Installing name-that-color for you."
    npm install name-that-color --global > /tmp/name-that-color-install.log
fi
