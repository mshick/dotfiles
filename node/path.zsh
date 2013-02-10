# ----------------------------------------------------------------------
# node.js in your PATH
# ----------------------------------------------------------------------

for dir (
  /usr/local/lib/node
  /usr/local/lib/node_modules
)
if [[ -d $dir ]];
  then export NODE_PATH=$dir:$NODE_PATH;
fi

# NPM binaries
for dir (
  /usr/local/share/npm
)
if [[ -d $dir ]];
  then export PATH=$dir/bin:$PATH;
fi
