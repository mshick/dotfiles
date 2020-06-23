#!/bin/sh

source "$DOTFILES/util/interactive"

info "running node/install"

if test ! $(which name-that-color)
then
    detail "name-that-color not found, installing"
    yarn global add name-that-color > /tmp/name-that-color-install.log
fi

if test ! $(which npm-check-updates)
then
    detail "npm-check-updates not found, installing"
    yarn global add npm-check-updates > /tmp/npm-check-updates-install.log
fi

if test ! $(which tsc)
then
    detail "typescript not found, installing"
    yarn global add typescript > /tmp/typescript-install.log
fi

if test ! $(which react-devtools)
then
    detail "react-devtools not found, installing"
    yarn global add react-devtools > /tmp/react-devtools-install.log
fi

success "node/install"

exit 0
