# init according to man page
export PATH=$HOME/.rbenv/bin:$PATH
if (( $+commands[rbenv] ))
then
  eval "$(rbenv init -)"
fi
