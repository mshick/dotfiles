# ----------------------------------------------------------------------
# node.js in your PATH
# ----------------------------------------------------------------------

# nvm env
if [[ $(brew ls --versions nvm) ]]
then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$(brew --prefix nvm)/nvm.sh" ] && . "$(brew --prefix nvm)/nvm.sh"
fi
