#!/bin/sh

# Sublime Text 3 install with Package Control

# Run this script with:
# $ curl -L git.io/sublimetext | sh

# Detect the architecture
if [ "$(uname -s)" == "Darwin" ]; then
    URL="http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%203065.dmg"
else
    exit;
fi

# Download the dmg, mount and install
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

# Symlink config
st3=~/Library/Application\ Support/Sublime\ Text\ 3
if [[ ! -d $st3 ]]; then
    mkdir $st3
fi

ln -s "${ZSH}/sublime-text-3/Installed\ Packages" "${st3}/Installed\ Packages"
ln -s "${ZSH}/sublime-text-3/Packages" "${st3}/Packages"

echo ""
echo "Sublime Text 3 installed successfully!"
echo "Run with: subl"
