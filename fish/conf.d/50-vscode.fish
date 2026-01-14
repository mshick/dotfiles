# VSCode shell integration
if set -q TERM_PROGRAM; and test "$TERM_PROGRAM" = vscode
    source (code --locate-shell-integration-path fish)
end
