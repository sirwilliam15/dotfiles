#!/bin/bash

if ! git remote get-url upstream &>/dev/null; then
    echo "Error: Upstream URL is not set. Please set it before proceeding."
    exit 1
fi

upstream_url=$(git remote get-url upstream)

if [[ "$upstream_url" == git@* || "$upstream_url" == ssh://* ]]; then
    eval $(ssh-agent)
    ssh-add "$HOME/.ssh/id_rsa"
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    head_branch=$(git remote show origin | ggrep -oP 'HEAD branch: \K.*')
else
    head_branch=$(git remote show origin | grep -oP 'HEAD branch: \K.*')
fi

original_branch=$(git branch --show-current)

if [[ -n $(git status --porcelain) ]]; then
    echo "------ Stashing Changes ------"
    git stash -u
    stashed=1
else
    stashed=0
fi

if [[ "$original_branch" != "$head_branch" ]]; then
    echo "------ Switching to $head_branch ------"
    git checkout $head_branch
fi

echo "------ Rebasing upstream into $head_branch ------"
git pull --rebase upstream $head_branch
git push

echo "------ Switching back to $original_branch ------"
git checkout $original_branch

if [[ "$1" == "--merge" ]]; then
    echo "------ Merging $head_branch into $original_branch ------"
    git merge $head_branch
fi

if [[ $stashed -ne 0 ]]; then
    echo "------ Popping Stash ------"
    git stash pop
fi