# Export paths
if [ "$(uname -m)" = "x86_64" ]; then
  export PATH=/usr/local/bin:$PATH
else
  export PATH=/opt/homebrew/bin:$PATH
fi
