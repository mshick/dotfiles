#!/bin/sh

source "$DOTFILES/util/interactive"

info "running zsh/install"

pushd $DOTFILES/zsh > /dev/null

if [[ ! -d "$HOME/.zim" ]]; then
    # Zsh IMproved FrameWork (ZIM) https://github.com/zimfw/zimfw
    detail "zim framework not found, installing"
    chsh -s $(which zsh)
    mkdir -p "$HOME/.zim"
    curl -L https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh -o "$HOME/.zim/zimfw.zsh"
    zsh ~/.zim/zimfw.zsh install
fi

if [[ ! -f "$HOME/.zprofile" ]]; then
    detail ".zprofile not found, installing"
    cp ./zprofile.example "$HOME/.zprofile"
fi

popd > /dev/null

success "zsh/install"

exit 0
