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
    $npm install spoof > /tmp/spoof-install.log
fi

if test ! $(which nodemon)
then
    echo "  Installing nodemon for you."
    $npm install nodemon > /tmp/nodemon-install.log
fi

exit 0
