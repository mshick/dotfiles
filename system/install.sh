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

if ! [[ $(brew ls --versions findutils) ]]
then
    echo "  Installing findutils for you."
    brew install findutils > /tmp/findutils-install.log
fi

echo "  Installing GNU utils for you."
brew install gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt > /tmp/gnuutils-install.log

exit 0
