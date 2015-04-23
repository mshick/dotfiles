#!/bin/sh

# Sublime Text 3 install with Package Control

# Detect the architecture
if [ ! "$(uname -s)" == "Darwin" ]
then
    exit;
fi

source "${ZSH}/util/interactive"

ST3=~/Library/'Application Support'/'Sublime Text 3'

# install_sublime () {
    # Run this script with:
    # $ curl -L git.io/sublimetext | sh
#     curl -o ~/st3.dmg $URL
#     mountpoint="/Volumes/Sublime Text"
#     IFS="
#     "
#     hdiutil attach -mountpoint $mountpoint ~/st3.dmg

#     for app in `find $mountpoint -type d -maxdepth 2 -name \*.app `; do
#       cp -a "$app" /Applications/
#     done

#     hdiutil detach $mountpoint
#     rm ~/st3.dmg
# }

link_config() {
    if [[ -d "${ST3}/Installed Packages" ]]
    then
       mv "${ST3}/Installed Packages" "${ST3}/Installed Packages.bak"
    fi

    if [[ -d "${ST3}/Packages" ]]
    then
        mv "${ST3}/Packages" "${ST3}/Packages.bak"
    fi

    if [[ -e "${ST3}/Installed Packages" ]]
    then
        ln -s "${ZSH}/sublime-text-3/Installed Packages" "${ST3}/Installed Packages"
    fi

    if [[ -e "${ST3}/Installed Packages" ]]
    then
        ln -s "${ZSH}/sublime-text-3/Packages" "${ST3}/Packages"
    fi
}

if ! [[ -e "~/Applications/Sublime Text.app" ]]
then
    info "Installing Sublime Text"

    # install_sublime
    brew cask install sublime-text3 --force

    # Symlink config
    if [[ ! -d $ST3 ]]; then
        mkdir $ST3
    fi

    info "Linking Sublime configuration files"

    link_config()

    echo ""
    echo "Sublime Text 3 installed successfully!"
    echo "Run with: subl"
fi
