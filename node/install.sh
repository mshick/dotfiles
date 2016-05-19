#!/usr/bin/env bash

if [ ! "$(uname -s)" == "Darwin" ]
then
    exit;
fi

if ! [ -x "$(command -v node)" ]
then
    echo "  Installing node.js for you."
    brew install node --without-npm > /tmp/node-install.log
fi

if ! [ -f node/npmrc.symlink ]
then
  sed -e "s|HOME|$HOME|g" node/npmrc.symlink.example > node/npmrc.symlink
  ln -s "node/npmrc.symlink" "$HOME/.npmrc"
fi

if ! [ -x "$(command -v npm)" ]
then
    echo "  Installing npm for you."
    curl -L https://www.npmjs.com/install.sh | sh
fi

npm="$(brew --prefix)/lib/node_modules/npm"

if test ! $(which spoof)
then
    echo "  Installing spoof for you."
    $npm install spoof --global > /tmp/spoof-install.log
fi

if test ! $(which nodemon)
then
    echo "  Installing nodemon for you."
    $npm install nodemon --global > /tmp/nodemon-install.log
fi

if test ! $(which gulp)
then
    echo "  Installing gulp for you."
    $npm install gulp --global > /tmp/gulp-install.log
fi

if test ! $(which name-that-color)
then
    echo "  Installing name-that-color for you."
    $npm install name-that-color --global > /tmp/name-that-color-install.log
fi

exit 0
