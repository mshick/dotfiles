#!/bin/sh
#
# Homebrew
#
# This runs first, during the bootstrap as part of bin/dot
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null
fi

# Install cask
brew install caskroom/cask/brew-cask
brew tap caskroom/versions

# Install core homebrew packages
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

if ! [[ $(brew ls --versions spark) ]]
then
    echo "  Installing spark for you."
    brew install spark > /tmp/spark-install.log
fi

exit 0
