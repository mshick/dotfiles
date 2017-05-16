git credential-osxkeychain
RESULT=$?
if [ $RESULT -eq 0 ]; then
  echo "foo";
  git config --global credential.helper osxkeychain
else
  echo "bar"
fi
