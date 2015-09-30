# ----------------------------------------------------------------------
# node.js in your PATH
# ----------------------------------------------------------------------

brew_prefix=/usr/local

node_path="$brew_prefix/lib/node"
if [[ -d $node_path ]]; then
    export NODE_PATH=$node_path
fi

# NPM binaries
npm_path="$brew_prefix/lib/node_modules/npm"
if [[ -d $npm ]]; then
    export PATH=$npm_path/bin:$PATH
fi
