#!/usr/bin/env bash

if [ ! "$(uname -s)" == "Darwin" ]
then
    exit;
fi

if ! [ -x "$(command -v node)" ]
then
    echo "  Installing node.js with nvm for you."
    mkdir "$HOME/.nvm"
    brew install nvm > /tmp/node-install.log
    export NVM_DIR="$HOME/.nvm"
    . "$(brew --prefix nvm)/nvm.sh"
    nvm install node
fi

if test ! $(which spoof)
then
    echo "  Installing spoof for you."
    npm install spoof --global > /tmp/spoof-install.log
fi

if test ! $(which nodemon)
then
    echo "  Installing nodemon for you."
    npm install nodemon --global > /tmp/nodemon-install.log
fi

if test ! $(which gulp)
then
    echo "  Installing gulp for you."
    npm install gulp --global > /tmp/gulp-install.log
fi

if test ! $(which name-that-color)
then
    echo "  Installing name-that-color for you."
    npm install name-that-color --global > /tmp/name-that-color-install.log
fi

exit 0
