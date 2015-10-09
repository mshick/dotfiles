# ----------------------------------------------------------------------
# node.js in your PATH
# ----------------------------------------------------------------------

# node binary
node_path="$(brew --prefix)/lib/node"
if [[ -d $node_path ]]
then
    export NODE_PATH=$node_path
fi

# npm binaries
npm_path="$HOME/.node/bin"
if [[ -d $npm_path ]]
then
    export PATH=$npm_path:$PATH
fi
