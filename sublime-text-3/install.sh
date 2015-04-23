#!/bin/sh

# Sublime Text 3 install with Package Control

# Detect the architecture
if [ ! "$(uname -s)" == "Darwin" ]
then
    exit;
fi

install_sublime () {
    # Run this script with:
    # $ curl -L git.io/sublimetext | sh
    curl -o ~/st3.dmg $URL
    mountpoint="/Volumes/Sublime Text"
    IFS="
    "
    hdiutil attach -mountpoint $mountpoint ~/st3.dmg

    for app in `find $mountpoint -type d -maxdepth 2 -name \*.app `; do
      cp -a "$app" /Applications/
    done

    hdiutil detach $mountpoint
    rm ~/st3.dmg
}

if ! [[ -e "~/Applications/Sublime Text.app" ]]
then
    # install_sublime
    brew cask install sublime-text3 --force

    # Symlink config
    st3=~/Library/'Application Support'/'Sublime Text 3'
    if [[ ! -d $st3 ]]; then
        mkdir $st3
    fi

    if [[ -d "${st3}/Installed Packages" ]]
    then
       mv "${st3}/Installed Packages" "${st3}/Installed Packages.bak"
    fi

    if ! [[ -d "${st3}/Packages" ]]
    then
        mv "${st3}/Packages" "${st3}/Packages.bak"
    fi

    ln -s "${ZSH}/sublime-text-3/Installed Packages" "${st3}/Installed Packages"
    ln -s "${ZSH}/sublime-text-3/Packages" "${st3}/Packages"

    echo ""
    echo "Sublime Text 3 installed successfully!"
    echo "Run with: subl"
fi
