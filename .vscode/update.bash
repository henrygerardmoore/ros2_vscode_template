#!/bin/bash
set -e

REPO_FILES=$(find -name .rolling.repos)
for file in $REPO_FILES
do
  vcs import src --input $file
done
sudo apt update ; sudo apt upgrade -y ; rosdep install --ignore-src --from-paths src -y -r