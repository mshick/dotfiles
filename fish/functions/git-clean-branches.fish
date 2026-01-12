function git-clean-branches -d "Remove local branches that are gone on the remote"
    git fetch --all --prune
    git branch --list --format \
        "%(if:equals=[gone])%(upstream:track)%(then)%(refname:short)%(end)" | xargs git branch -D
end
