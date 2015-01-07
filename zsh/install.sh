#!/usr/bin/env bash

if ! [[ $(brew ls --versions zsh-syntax-highlighting) ]]
then
    echo "  Installing zsh-syntax-highlighting for you."
    brew install zsh-syntax-highlighting > /tmp/zsh-syntax-highlighting-install.log
fi

if ! [[ $(brew ls --versions zsh-history-substring-search) ]]
then
    echo "  Installing zsh-history-substring-search for you."
    brew install zsh-history-substring-search > /tmp/zsh-history-substring-search-install.log
fi

exit 0
