#!/bin/sh

source "${ZSH}/util/interactive"

info "running node/install"

if test ! $(which name-that-color)
then
    detail "name-that-color not found, installing"
    npm install --global name-that-color > /tmp/name-that-color-install.log
fi

if test ! $(which npm-check-updates)
then
    detail "npm-check-updates not found, installing"
    npm install --global npm-check-updates > /tmp/npm-check-updates-install.log
fi

if test ! $(which tsc)
then
    detail "typescript not found, installing"
    npm install --global typescript > /tmp/typescript-install.log
fi

if test ! $(which react-devtools)
then
    detail "react-devtools not found, installing"
    npm install --global react-devtools > /tmp/react-devtools-install.log
fi

success "node/install"

exit 0
