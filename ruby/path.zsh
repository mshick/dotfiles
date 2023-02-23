export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="${GEM_HOME}:${PATH}"
