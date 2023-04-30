#!/bin/bash

set -e

# Default values for input parameters
username=""
email=""
commit_message=""

# Parse command line arguments
while getopts "u:e:m:" opt; do
  case ${opt} in
    u )
      username=$OPTARG
      ;;
    e )
      email=$OPTARG
      ;;
    m )
      commit_message=$OPTARG
      ;;
    \? )
      echo "Invalid option: -$OPTARG" 1>&2
      exit 1
      ;;
    : )
      echo "Option -$OPTARG requires an argument." 1>&2
      exit 1
      ;;
  esac
done

# If no command line arguments were provided, check for environment variables
if [[ -z "$username" && -z "$email" ]]; then
  username=${USERNAME}
  email=${EMAIL}
  commit_message=${COMMIT_MESSAGE}
fi


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