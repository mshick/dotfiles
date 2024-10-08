#!/bin/sh

export ZSH=$HOME/.dotfiles

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

# Source utils
source "${ZSH}/util/interactive"

# Set up for failure
set -e

# Install symlinks
install_dotfiles() {
  local overwrite_all=false backup_all=false skip_all=false
  for src in $(find -H "${ZSH}" -maxdepth 2 -name '*.symlink'); do
    dst="$HOME/.$(basename "${src%.*}")"
    link_file "$src" "$dst"
  done
}

info "installing dotfile symlinks"
install_dotfiles

# Install ZSH
${ZSH}/zsh/install.sh

# Install Homebrew
${ZSH}/homebrew/install.sh

# Find the other installers and run them

find ${ZSH} -name "install.sh" -not \( -path "**/homebrew/*" -o -path "**/zsh/*" \) | while read installer; do
  sh -c "${installer}"
done

success "done installing!"
