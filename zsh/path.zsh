syntax_path="$(brew --prefix)/share/zsh-syntax-highlighting"

if [[ -d $syntax_path ]]; then
    export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="${syntax_path}/highlighters"
fi
