#!/bin/bash -e
# given a commit, find immediate children of that commit.
for arg in "$@"; do
  for commit in $(git rev-parse $arg^0); do
    for child in $(git log --format='%H %P' --all | grep -F " $commit" | cut -f1 -d' '); do
      git describe $child
    done
  done
done
