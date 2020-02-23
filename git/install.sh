#!/usr/bin/env bash

git credential-osxkeychain

RESULT=$?

if [ $RESULT -eq 0 ]; then
  echo "  Setting osxkeychain as git credential helper."
  git config --global credential.helper osxkeychain
fi
