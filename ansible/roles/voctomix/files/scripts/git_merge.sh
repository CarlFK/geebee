#!/bin/bash -ex

# merge a bunch of brances into main
# good for testing pending PRs

git config user.email "videotesam@example.com"
git config user.name "video team"

git switch main

while (( "$#" )); do
    git merge ${1} --message="merged by ${0}"
    shift
done
