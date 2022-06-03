#!/bin/sh

source "${ZSH}/util/interactive"

info "running node/install"

if test ! $(which name-that-color); then
  detail "name-that-color not found, installing"
  npm install --global name-that-color >/tmp/name-that-color-install.log
fi

if test ! $(which tsc); then
  detail "typescript not found, installing"
  npm install --global typescript >/tmp/typescript-install.log
fi

success "node/install"

exit 0
