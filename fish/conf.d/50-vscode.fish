# VSCode shell integration
if set -q TERM_PROGRAM; and test "$TERM_PROGRAM" = vscode
    source (code --locate-shell-integration-path fish)

    # Ensure NVM gets set up
    set --query XDG_DATA_HOME || set --local XDG_DATA_HOME ~/.local/share
    set --query nvm_mirror || set --global nvm_mirror https://nodejs.org/dist
    set --query nvm_data || set --global nvm_data $XDG_DATA_HOME/nvm

    if set --query nvm_current_version
        set -e nvm_current_version
    end

    if set --query nvm_default_version && ! set --query nvm_current_version
        nvm use --silent "$nvm_default_version"
    end
end
