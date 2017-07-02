# ----------------------------------------------------------------------
# node.js in your PATH
# ----------------------------------------------------------------------

_nvm_load() {
  . "$(brew --prefix nvm)/nvm.sh"
}

_nvm_global_binaries() {
  # Look for global binaries
  local global_binary_paths="$(echo "$NVM_DIR"/v0*/bin/*(N) "$NVM_DIR"/versions/*/*/bin/*(N))"

  # If we have some, format them
  if [[ -n "$global_binary_paths" ]]; then
    echo "$NVM_DIR"/v0*/bin/*(N) "$NVM_DIR"/versions/*/*/bin/*(N) |
      xargs -n 1 basename |
      sort |
      uniq
  fi
}

_nvm_lazy_load() {
  # Get all global node module binaries including node
  local global_binaries

  global_binaries=($(_nvm_global_binaries))

  # Add nvm
  global_binaries+=('nvm')

  # Remove any binaries that conflict with current aliases
  local cmds
  cmds=()
  for bin in $global_binaries; do
    [[ "$(which $bin)" = "$bin: aliased to "* ]] || cmds+=($bin)
  done

  # Create function for each command
  for cmd in $cmds; do

    # When called, unset all lazy loaders, load nvm then run current command
    eval "$cmd(){
      unset -f $cmds
      _nvm_load
      $cmd \"\$@\"
    }"
  done
}

# nvm env
if [[ $(brew ls --versions nvm) ]]
then
    export NVM_DIR="$HOME/.nvm"
    _nvm_lazy_load
    # [ -s "$(brew --prefix nvm)/nvm.sh" ] && . "$(brew --prefix nvm)/nvm.sh"
fi
