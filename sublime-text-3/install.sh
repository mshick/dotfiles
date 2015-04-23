#!/bin/sh

# Sublime Text 3 install with Package Control

# Detect the architecture
if [ ! "$(uname -s)" == "Darwin" ]
then
    exit;
fi

set -e

echo ''

source "${ZSH}/util/interactive"

ST3=~/Library/'Application Support'/'Sublime Text 3'

if ! [[ -e "~/Applications/Sublime Text.app" ]]
then

    echo "Installing Sublime Text"
    echo ""

    # install_sublime
    brew cask install sublime-text3 --force

    success "Sublime Text installed"

    # Symlink config
    if [[ ! -d $ST3 ]]; then
        mkdir $ST3
    fi

    info "Linking Sublime configuration files"

    link_file "${ZSH}/sublime-text-3/Installed Packages" "${ST3}/Installed Packages"
    link_file "${ZSH}/sublime-text-3/Packages" "${ST3}/Packages"

    success "Configuration files linked"

    echo ""
    echo "Sublime Text 3 installed successfully!"
    echo "Run with: subl"
fi
