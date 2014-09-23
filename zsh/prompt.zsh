autoload colors && colors

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
