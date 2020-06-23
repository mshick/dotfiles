#!/bin/sh

source "$DOTFILES/util/interactive"

info "running nix/install"

if [ ! $(which nix) ]; then
    detail "nix not found, installing"
    curl -fsSL https://nixos.org/nix/install | sh /dev/stdin --darwin-use-unencrypted-nix-store-volume
    source "${HOME}/.nix-profile/etc/profile.d/nix.sh"
fi

if [ ! $(which direnv) ]; then
    detail "direnv not found, installing"
    nix-env -i direnv
fi

success "nix/install"

exit 0
