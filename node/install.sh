#!/usr/bin/env bash

if [ ! "$(uname -s)" == "Darwin" ]
then
    exit;
fi

if test ! $(which node)
then
    echo "  Installing node.js for you."
    brew install node > /tmp/node-install.log
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
