# ----------------------------------------------------------------------
# Syntax highlighting
# Sourced from brew installed code
# ----------------------------------------------------------------------

syntax_path="$(brew --prefix zsh-syntax-highlighting)/share/zsh-syntax-highlighting"

if [[ -d $syntax_path ]]; then
    source "${syntax_path}/zsh-syntax-highlighting.zsh"
    export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="${syntax_path}/highlighters"
else
    echo "zsh-syntax-highlighting not installed"
fi


# ----------------------------------------------------------------------
# History substring search
# Sourced from brew installed code
# ----------------------------------------------------------------------

history_path="$(brew --prefix zsh-history-substring-search)/share/zsh-history-substring-search"

if [[ -d $history_path ]]; then
    source "${history_path}/zsh-history-substring-search.zsh"

    # bind UP and DOWN arrow keys
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
else
    echo "zsh-history-substring-search not installed"
fi
