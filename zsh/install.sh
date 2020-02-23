#!/bin/sh
#
# Zsh IMproved FrameWork (ZIM)
# https://github.com/zimfw/zimfw

# Check for ZIM
ZIM_CONFIG_DIR=~/.zim

if [[ ! -d "$ZIM_CONFIG_DIR" ]]; then
  echo "  Installing Zsh IMproved FrameWork (ZIM) for you."
  curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
fi