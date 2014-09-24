# To install source this file from your .zshrc file

# see documentation at http://linux.die.net/man/1/zshexpn
# A: finds the absolute path, even if this is symlinked
# h: equivalent to dirname
export __GIT_PROMPT_DIR=${0:A:h}

export GIT_PROMPT_EXECUTABLE=${GIT_PROMPT_USE_PYTHON:-"python"}

# Initialize colors.
autoload -U colors
colors

# Allow for functions in the prompt.
setopt PROMPT_SUBST

autoload -U add-zsh-hook

add-zsh-hook chpwd chpwd_update_git_vars
add-zsh-hook preexec preexec_update_git_vars
add-zsh-hook precmd precmd_update_git_vars

## Function definitions
function preexec_update_git_vars() {
    case "$2" in
        git*|hub*|gh*|stg*)
        __EXECUTED_GIT_COMMAND=1
        ;;
    esac
}

function precmd_update_git_vars() {
    if [ -n "$__EXECUTED_GIT_COMMAND" ] || [ ! -n "$ZSH_THEME_GIT_PROMPT_CACHE" ]; then
        update_current_git_vars
        unset __EXECUTED_GIT_COMMAND
    fi
}

function chpwd_update_git_vars() {
    update_current_git_vars
}

function update_current_git_vars() {
    unset __CURRENT_GIT_STATUS

    if [[ "$GIT_PROMPT_EXECUTABLE" == "python" ]]; then
        local gitstatus="$__GIT_PROMPT_DIR/gitstatus.py"
        _GIT_STATUS=`python ${gitstatus} 2>/dev/null`
    fi

    if [[ "$GIT_PROMPT_EXECUTABLE" == "haskell" ]]; then
        local gitstatus="$__GIT_PROMPT_DIR/dist/build/gitstatus/gitstatus"
        _GIT_STATUS=`${gitstatus}`
    fi

    __CURRENT_GIT_STATUS=("${(@f)_GIT_STATUS}")

    GIT_BRANCH=$__CURRENT_GIT_STATUS[1]
    GIT_AHEAD=$__CURRENT_GIT_STATUS[2]
    GIT_BEHIND=$__CURRENT_GIT_STATUS[3]
    GIT_STAGED=$__CURRENT_GIT_STATUS[4]
    GIT_CONFLICTS=$__CURRENT_GIT_STATUS[5]
    GIT_CHANGED=$__CURRENT_GIT_STATUS[6]
    GIT_UNTRACKED=$__CURRENT_GIT_STATUS[7]
}


git_super_status() {

    precmd_update_git_vars

    if [ -n "$__CURRENT_GIT_STATUS" ]; then

        STATUS="$ZSH_THEME_GIT_PROMPT_PREFIX$ZSH_THEME_GIT_PROMPT_BRANCH$GIT_BRANCH%{${reset_color}%}"

        if [ "$GIT_BEHIND" -ne "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_BEHIND$GIT_BEHIND%{${reset_color}%}"
        fi
        if [ "$GIT_AHEAD" -ne "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_AHEAD$GIT_AHEAD%{${reset_color}%}"
        fi

        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_SEPARATOR"

        if [ "$GIT_STAGED" -ne "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STAGED$GIT_STAGED%{${reset_color}%}"
        fi
        if [ "$GIT_CONFLICTS" -ne "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CONFLICTS$GIT_CONFLICTS%{${reset_color}%}"
        fi
        if [ "$GIT_CHANGED" -ne "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CHANGED$GIT_CHANGED%{${reset_color}%}"
        fi
        if [ "$GIT_UNTRACKED" -ne "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED%{${reset_color}%}"
        fi
        if [ "$GIT_CHANGED" -eq "0" ] && [ "$GIT_CONFLICTS" -eq "0" ] && [ "$GIT_STAGED" -eq "0" ] && [ "$GIT_UNTRACKED" -eq "0" ]; then
            STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CLEAN"
        fi

        STATUS="$STATUS%{${reset_color}%}$ZSH_THEME_GIT_PROMPT_SUFFIX_CLEAN%{${reset_color}%}"
        echo "$STATUS"
    fi
}

# Default values for the appearance of the prompt. Configure at will.
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[magenta]%}■ "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_SEPARATOR="%{$fg_bold[magenta]%} "
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[yellow]%}%{●%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg_bold[red]%}%{✖%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg_bold[cyan]%}%{+%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{↓%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{↑%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[blue]%}%{…%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}%{✔%G%}"





# # To install source this file from your .zshrc file

# # Change this to reflect your installation directory
# export __GIT_PROMPT_DIR=$ZSH/git
# # Initialize colors.
# autoload -U colors
# colors

# # Allow for functions in the prompt.
# setopt PROMPT_SUBST

# autoload -U add-zsh-hook

# add-zsh-hook chpwd chpwd_update_git_vars
# add-zsh-hook preexec preexec_update_git_vars
# add-zsh-hook precmd precmd_update_git_vars

# ## Function definitions
# function preexec_update_git_vars() {
#     case "$2" in
#         git*)
#         __EXECUTED_GIT_COMMAND=1
#         ;;
#     esac
# }

# function precmd_update_git_vars() {
#     if [ -n "$__EXECUTED_GIT_COMMAND" ] || [ -n "$ZSH_THEME_GIT_PROMPT_NOCACHE" ]; then
#         update_current_git_vars
#         unset __EXECUTED_GIT_COMMAND
#     fi
# }

# function chpwd_update_git_vars() {
#     update_current_git_vars
# }

# function update_current_git_vars() {
#     unset __CURRENT_GIT_STATUS

#     local gitstatus="$__GIT_PROMPT_DIR/gitstatus.py"
#     _GIT_STATUS=`python ${gitstatus}`
#     __CURRENT_GIT_STATUS=("${(@f)_GIT_STATUS}")
#   GIT_BRANCH=$__CURRENT_GIT_STATUS[1]
#   GIT_REMOTE=$__CURRENT_GIT_STATUS[2]
#   GIT_STAGED=$__CURRENT_GIT_STATUS[3]
#   GIT_CONFLICTS=$__CURRENT_GIT_STATUS[4]
#   GIT_CHANGED=$__CURRENT_GIT_STATUS[5]
#   GIT_UNTRACKED=$__CURRENT_GIT_STATUS[6]
#   GIT_CLEAN=$__CURRENT_GIT_STATUS[7]
# }

# # File completion gets very slow without this
# __git_files () {
#     _wanted files expl 'local files' _files
# }

# git_super_status() {
#   precmd_update_git_vars
#   if [ -n "$__CURRENT_GIT_STATUS" ]; then
#     STATUS="($GIT_BRANCH"
#     STATUS="$ZSH_THEME_GIT_PROMPT_PREFIX$ZSH_THEME_GIT_PROMPT_BRANCH$GIT_BRANCH%{${reset_color}%}"
#     if [ -n "$GIT_REMOTE" ]; then
#       STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_REMOTE$GIT_REMOTE%{${reset_color}%}"
#     fi
#     STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_SEPARATOR"
#     if [ "$GIT_STAGED" -ne "0" ]; then
#       STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STAGED$GIT_STAGED%{${reset_color}%}"
#     fi
#     if [ "$GIT_CONFLICTS" -ne "0" ]; then
#       STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CONFLICTS$GIT_CONFLICTS%{${reset_color}%}"
#     fi
#     if [ "$GIT_CHANGED" -ne "0" ]; then
#       STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CHANGED$GIT_CHANGED%{${reset_color}%}"
#     fi
#     if [ "$GIT_UNTRACKED" -ne "0" ]; then
#       STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED%{${reset_color}%}"
#     fi
#     STATUS="$STATUS%{${reset_color}%}$ZSH_THEME_GIT_PROMPT_SUFFIX%{${reset_color}%}"
#     if [ "$GIT_CLEAN" -eq "1" ]; then
#       STATUS="($GIT_BRANCH"
#       STATUS="$ZSH_THEME_GIT_PROMPT_PREFIX_CLEAN$ZSH_THEME_GIT_PROMPT_BRANCH_CLEAN$GIT_BRANCH%{${reset_color}%}"
#       STATUS="$STATUS%{${reset_color}%}$ZSH_THEME_GIT_PROMPT_SUFFIX_CLEAN%{${reset_color}%}"
#     fi
#     echo "$STATUS"
#   fi
# }

# # Default values for the appearance of the prompt. Configure at will.
# ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[magenta]%}■ "
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[magenta]%}"
# ZSH_THEME_GIT_PROMPT_SEPARATOR="%{$fg_bold[magenta]%} "
# ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[magenta]%}"
# ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[yellow]%}●"
# ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg_bold[red]%}x"
# ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg_bold[green]%}+"
# ZSH_THEME_GIT_PROMPT_REMOTE=""
# ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[blue]%}…"
# ZSH_THEME_GIT_PROMPT_PREFIX_CLEAN="%{$fg_bold[grey]%}■ "
# ZSH_THEME_GIT_PROMPT_SUFFIX_CLEAN="%{$fg_bold[grey]%}"
# ZSH_THEME_GIT_PROMPT_BRANCH_CLEAN="%{$fg_bold[grey]%}"

