# ----------------------------------------------------------------------
# Syntax highlighting
# Sourced from brew installed code
# ----------------------------------------------------------------------

syntax_path="$(brew --prefix)/share/zsh-syntax-highlighting"

if [[ -d $syntax_path ]]; then
    source "${syntax_path}/zsh-syntax-highlighting.zsh"
    export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="${syntax_path}/highlighters"
fi


# ----------------------------------------------------------------------
# History substring search
# Sourced from brew installed code
# ----------------------------------------------------------------------

history_path="$(brew --prefix)/opt/zsh-history-substring-search"

if [[ -d $history_path ]]; then
    source "${history_path}/zsh-history-substring-search.zsh"

    # bind UP and DOWN arrow keys
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
fi
