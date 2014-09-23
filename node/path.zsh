# ----------------------------------------------------------------------
# node.js in your PATH
# ----------------------------------------------------------------------

node="$(brew --prefix)/lib/node"
if [[ -d $node ]];
  then export NODE_PATH=$node;
fi

# NPM binaries
npm="$(brew --prefix)/lib/node_modules/npm"
if [[ -d $npm ]];
  then export PATH=$npm/bin:$PATH;
fi
