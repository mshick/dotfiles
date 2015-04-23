#!/bin/sh

# Fonts with [Homebrew Fonts](https://github.com/caskroom/homebrew-fonts)

# Only for OSX
if [ ! "$(uname -s)" == "Darwin" ]
then
    exit;
fi

source "${ZSH}/util/files"

if no_file_exists ~/Library/Fonts/SourceCodePro
then
    brew cask install font-source-code-pro
fi
