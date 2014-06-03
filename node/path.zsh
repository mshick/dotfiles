# ----------------------------------------------------------------------
# node.js in your PATH
# ----------------------------------------------------------------------

node=/usr/local/lib/node
if [[ -d $node ]];
  then export NODE_PATH=$node;
fi

# NPM binaries
npm=/usr/local/lib/node_modules/npm
if [[ -d $npm ]];
  then export PATH=$npm/bin:$PATH;
fi
