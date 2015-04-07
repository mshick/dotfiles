# ----------------------------------------------------------------------
# node.js in your PATH
# ----------------------------------------------------------------------

# node_path="$(brew --prefix)/lib/node"
# if [[ -d $node_path ]]; then
#     export NODE_PATH=$node_path
# fi

nvm_dir="$(brew --prefix)/var/nvm"
if [[ -d $nvm_dir ]]; then
    export NVM_DIR=$nvm_dir
    source $(brew --prefix nvm)/nvm.sh
fi

# NPM binaries
npm_path="$(brew --prefix)/lib/node_modules/npm"
if [[ -d $npm ]]; then
    export PATH=$npm_path/bin:$PATH
fi
