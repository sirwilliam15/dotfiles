#!/bin/bash

original_branch=$(git branch --show-current)
head_branch=$(git remote show origin | grep -oP 'HEAD branch: \K.*')

if [[ "$original_branch" != "$head_branch" ]]; then
    git checkout $head_branch
fi

git pull --rebase upstream $original_branch
git push

git checkout $original_branch

if [[ "$1" == "--merge" ]]; then
    git merge $head_branch
fi
