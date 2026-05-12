#!/bin/bash -ex

# merge a bunch of brances into main
# good for testing pending PRs

date |tee --append git_merge.log

git config --global user.email "you@example.com"|tee --append git_merge.log
git config --global user.name "Your Name"|tee --append git_merge.log

git switch main |tee --append git_merge.log

while (( "$#" )); do
    git merge ${1}|tee --append git_merge.log
    shift
done
