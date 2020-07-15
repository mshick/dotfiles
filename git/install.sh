#!/bin/sh

source "${ZSH}/util/interactive"

info "running git/install"

if ! [ -f "$HOME/.gitconfig.local" ]; then
    pushd ${ZSH}/git > /dev/null

    detail "installing gitconfig.local"

    git_credential='osxkeychain'

    user ' - What is your github username?'
    read -e git_username
    user ' - What is your github author name?'
    read -e git_authorname
    user ' - What is your github author email?'
    read -e git_authoremail
    user ' - What is your GPG signing key?'
    read -e git_signingkey

    sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/USERNAME/$git_username/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" -e "s/SIGNINGKEY/$git_signingkey/g" ./gitconfig.local.example > "$HOME/.gitconfig.local"
    mkdir -p $HOME/.config && sed -e "s/AUTHORNAME/$git_authorname/g" ./hub.example > "$HOME/.config/hub"

    popd > /dev/null
fi

success "git/install"

exit 0
