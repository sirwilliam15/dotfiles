#!/bin/bash

original_branch=$(git branch --show-current)
head_branch=$(git remote show origin | grep -oP 'HEAD branch: \K.*')

git checkout $head_branch

git pull --rebase upstream $original_branch
git push

git checkout $original_branch

if [[ "$1" == "--merge" ]]; then
    git merge $head_branch
fi
