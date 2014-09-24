# ----------------------------------------------------------------------
# node.js in your PATH
# ----------------------------------------------------------------------

node_path="$(brew --prefix)/lib/node"
if [[ -d $node_path ]]; then
    export NODE_PATH=$node_path
fi

# NPM binaries
npm_path="$(brew --prefix)/lib/node_modules/npm"
if [[ -d $npm ]]; then
    export PATH=$npm_path/bin:$PATH
fi
