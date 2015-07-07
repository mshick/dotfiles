#!/bin/sh

# Apps with Homebrew Casks

# Only for OSX
if [ ! "$(uname -s)" == "Darwin" ]
then
    exit;
fi

# Install casks
brew cask ls google-chrome > /dev/null || brew cask install google-chrome
brew cask ls unrarx > /dev/null || brew cask install unrarx
brew cask ls firefox > /dev/null || brew cask install firefox
brew cask ls xld > /dev/null || brew cask install xld
brew cask ls vlc > /dev/null || brew cask install vlc
brew cask ls sublime-text3 > /dev/null || brew cask install sublime-text3
