#!/bin/bash -ex

# merge a bunch of brances into main
# good for testing pending PRs

git switch main

while (( "$#" )); do
    git merge ${1}
    shift
done
