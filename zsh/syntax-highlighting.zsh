# ----------------------------------------------------------------------
# Syntax highlighting
# Sourced from brew installed code
# ----------------------------------------------------------------------

syntax_path="$(brew --prefix)/share/zsh-syntax-highlighting"

if [[ -d $syntax_path ]]; then
    source "${syntax_path}/zsh-syntax-highlighting.zsh"
fi
