#!/bin/bash

set -e

# Configure Git user and email
git config --global user.email "$email"
git config --global user.name "$username"
git config --global --add safe.directory '*'

# Add changes to the index
if [ -n "$(git status --porcelain)" ]; then
  git add .

  # Commit changes with specified message
  git commit -m "$commit_message"

  # Push changes to the remote repository
  git remote set-url origin https://"$username":"$github_token"@github.com/"$repository".git
  git push origin "$branch"

fi