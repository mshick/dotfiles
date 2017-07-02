#!/bin/sh
#
# Atom
#
# Create an atom config directory in iCloud Drive.

if [ ! -e ".atom" ]; then
  echo "Linking ~/.atom to iCloud Drive"
  ln -s "~/Library/Mobile Documents/com~apple~CloudDocs/.atom"
fi
