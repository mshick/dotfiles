autoload colors && colors

# This keeps the number of todos always available the right hand side of my
# command line. I filter it to only count those tagged as "+next", so it's more
# of a motivation to clear out the list.
todo(){
  if (( $+commands[todo.sh] ))
  then
    num=$(echo $(todo.sh ls +next | wc -l))
    let todos=num-2
    if [ $todos != 0 ]
    then
      echo "$todos"
    else
      echo ""
    fi
  else
    echo ""
  fi
}

path(){
  d=$(print -P '%3~')
  case $d in
    ('~'*|/*) echo "$d";;
    (*)       echo "...$d"
  esac
}

directory_name(){
  echo "%{$fg_bold[green]%}$(path)%\/%{$reset_color%}"
}

# git_super_status imported from git/git-prompt.zsh
export PROMPT=$'\n  $(directory_name) $(git_super_status)\n❯ '

set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}$(todo)%{$reset_color%}"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
