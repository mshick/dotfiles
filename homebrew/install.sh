#!/bin/sh

source "$DOTFILES/util/interactive"

info "running homebrew/install"

if test ! $(which brew)
then
    detail "homebrew not found, installing"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

user "Which brew bundle should I install? Type 'server' or 'client'."

read -e bundle_type

pushd "$DOTFILES/homebrew/bundles/$bundle_type" > /dev/null

detail "installing ${bundle_type} homebrew bundle"
brew update > /dev/null
brew bundle -v

popd > /dev/null

success "homebrew/install"

exit 0
