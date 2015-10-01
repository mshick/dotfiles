#!/usr/bin/env bash

if [ ! "$(uname -s)" == "Darwin" ]
then
    exit;
fi

brew cask ls virtualbox > /dev/null || brew cask install virtualbox

if ! [ -x "$(command -v docker)" ] && ! [[ $(brew ls --versions docker) ]]
then
  echo "  Installing docker for you."
  brew install docker > /tmp/docker-install.log
fi

if ! [ -x "$(command -v boot2docker)" ] && ! [[ $(brew ls --versions boot2docker) ]]
then
  echo "  Installing boot2docker for you."
  brew install boot2docker > /tmp/boot2docker-install.log
fi

exit 0
