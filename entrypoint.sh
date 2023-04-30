#!/bin/bash

set -e

# Configure Git user and email
git config --global user.email "$email"
git config --global user.name "$username"

# Add changes to the index
if [ -n "$(git status --porcelain)" ]; then
  git add .

  # Commit changes with specified message
  git commit -m "$commit_message"

  # Push changes to the remote repository
  git push "$remote" "$branch" -u "$username" -p "$github_token"
fi