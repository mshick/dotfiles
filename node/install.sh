#!/usr/bin/env bash

if test ! $(which node)
then
    echo "  Installing io.js & node using nvm for you. [io.js is default]"
    brew install nvm > /tmp/nvm-install.log

    export NVM_DIR=$nvm_dir
    source $(brew --prefix nvm)/nvm.sh

    nvm install node > /tmp/node-install.log
    nvm install iojs > /tmp/iojs-install.log
    nvm use iojs
    nvm alias default iojs
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

if test ! $(which gulp)
then
    echo "  Installing gulp for you."
    $npm install gulp > /tmp/gulp-install.log
fi

exit 0
