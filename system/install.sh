#!/usr/bin/env bash

if test ! $(which grc) && ! [[ $(brew ls --versions grc) ]]
then
    echo "  Installing grc for you."
    brew install grc > /tmp/grc-install.log
fi

if ! [[ $(brew ls --versions coreutils) ]]
then
    echo "  Installing coreutils for you."
    brew install coreutils > /tmp/coreutils-install.log
fi

exit 0
