#!/bin/sh

source "${ZSH}/util/interactive"

if [ ! "$(uname -s)" == "Darwin" ]
then
    fail 'Unsupported platform'
    exit;
fi

plist_name="dotfiles.virtualbootcamp.plist"

if ! [ -f /Library/LaunchDaemons/$plist_name ]
    then
        info 'Setup VirtualBootcamp LauchDaemon'

        user ' - What is your Bootcamp partition name? [BOOTCAMP]'
        read -e partition

        dirname="${ZSH}/optional/virtualbootcamp"
        partition=${partition:-BOOTCAMP}

        sed -e "s;\${PATH};$dirname;g" -e "s;\${PARTITION};$partition;g" -e "s;\${PLIST_NAME};$plist_name;g" "${dirname}/dotfiles.virtualbootcamp.plist.example" > "${dirname}/dotfiles.virtualbootcamp.plist"
        sudo cp "${dirname}/dotfiles.virtualbootcamp.plist" /Library/LaunchDaemons/dotfiles.virtualbootcamp.plist
        sudo chown root /Library/LaunchDaemons/dotfiles.virtualbootcamp.plist
        sudo launchctl load -w /Library/LaunchDaemons/dotfiles.virtualbootcamp.plist

        success 'VirtualBootcamp LaunchDaemon installed'
fi
