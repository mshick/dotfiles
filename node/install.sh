#!/usr/bin/env bash

if test ! $(which name-that-color)
then
    echo "  Installing name-that-color for you."
    npm install name-that-color --global > /tmp/name-that-color-install.log
fi
