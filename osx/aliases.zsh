# Thanks to: http://justinlilly.com/dotfiles/zsh.html

# Mac Helpers
alias show_hidden="defaults write com.apple.Finder AppleShowAllFiles YES && killall Finder"
alias hide_hidden="defaults write com.apple.Finder AppleShowAllFiles NO && killall Finder"

screen-sharing() {
    start_cmd="sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.screensharing.plist"
    stop_cmd="sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.screensharing.plist"

    if [[ $@ = "restart" ]]; then
        echo "Restarting..."
        eval "${stop_cmd} && ${start_cmd}"
    fi

    if [[ $@ = "start" ]]; then
        echo "Starting..."
        eval $start_cmd
    fi

    if [[ $@ = "stop" ]]; then
        echo "Stopping..."
        eval $stop_cmd
    fi
}
