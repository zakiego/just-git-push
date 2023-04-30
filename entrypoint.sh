#!/bin/bash

set -e

# Configure Git user and email
git config --global user.email "$EMAIL"
git config --global user.name "$USERNAME"
git config --global --add safe.directory '*'

# Add changes to the index
if [ -n "$(git status --porcelain)" ]; then
  git add .

  # Commit changes with specified message
  git commit -m "$COMMIT_MESSAGE"

  # Push changes to the remote repository
  git remote set-url origin https://"$USERNAME":"$GITHUB_TOKEN"@github.com/"$REPOSITORY".git
  git remote -v
  git push origin "$BRANCH"

  echo "Changes pushed to remote repository 🥳🎉"
else
  echo "No changes to commit 😥"
fi