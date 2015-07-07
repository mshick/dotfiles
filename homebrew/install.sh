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

brew tap gapple/services
brew tap mshick/personal
brew tap caskroom/versions
brew tap caskroom/fonts

# Install cask
if ! [[ $(brew ls --versions brew-cask) ]]
then
    brew install caskroom/cask/brew-cask
fi

exit 0
