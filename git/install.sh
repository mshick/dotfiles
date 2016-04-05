#!/usr/bin/env bash

if [ ! "$(uname -s)" == "Darwin" ]
then
    exit;
fi

if ! [ -x "$(command -v hub)" ] && ! [[ $(brew ls --versions hub) ]]
then
  echo "  Installing hub for you."
  brew install hub > /tmp/hub-install.log
fi

exit 0
