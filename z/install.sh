#!/usr/bin/env bash

if test ! $(which z) && ! [[ $(brew ls --versions z) ]]
then
  echo "  Installing z for you."
  brew install z > /tmp/z-install.log
fi

exit 0
