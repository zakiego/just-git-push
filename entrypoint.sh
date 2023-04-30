#!/bin/bash

set -e

# Get input variables from workflow YAML file
username="$1"
email="$2"
commit_message="$3"

# Configure Git user and email

git config --global user.email "$email"
git config --global user.name "$username"

# Add changes to the index
if [ -n "$(git status --porcelain)" ]; then
  git add .

  # Commit changes with specified message
  git commit -m "$commit_message"

  # Push changes to the remote repository
  git push
fi
