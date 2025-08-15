#!/bin/bash

# Function to configure Git user and email
configure_git_user() {
    if [ -z "$GIT_USER" ] || [ -z "$GIT_EMAIL" ]; then
        echo "Warning: GIT_USER and/or GIT_EMAIL environment variables are not set"
        echo "Git commits will use your global Git configuration"
        echo "To set these variables, run:"
        echo "export GIT_USER='Your Name'"
        echo "export GIT_EMAIL='your.email@example.com'"
        return 1
    fi

    echo "------ Configuring Git user and email ------"
    git config user.name "$GIT_USER"
    git config user.email "$GIT_EMAIL"
    return 0
}

# Check if two arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <forked_repo_url> <original_repo_url>"
    echo "Example: $0 https://github.com/yourusername/repo.git https://github.com/original/repo.git"
    exit 1
fi

FORKED_REPO=$1
ORIGINAL_REPO=$2

# Extract repository name from the forked repo URL
REPO_NAME=$(basename "$FORKED_REPO" .git)

echo "Setting up repository: $REPO_NAME"
echo "Forked repo: $FORKED_REPO"
echo "Original repo: $ORIGINAL_REPO"

# Clone the forked repository
echo "------ Cloning forked repository ------"
if [[ "$FORKED_REPO" == git@* || "$FORKED_REPO" == ssh://* ]]; then
    eval $(ssh-agent)
    ssh-add "$HOME/.ssh/id_rsa"
fi
if ! git clone "$FORKED_REPO"; then
    echo "Error: Failed to clone the forked repository"
    exit 1
fi

# Change into the repository directory
cd "$REPO_NAME" || exit 1

# Configure Git user and email
configure_git_user

# Add the original repository as upstream remote
echo "------ Adding upstream remote ------"
if ! git remote add upstream "$ORIGINAL_REPO"; then
    echo "Error: Failed to add upstream remote"
    exit 1
fi

# Verify the remotes and configuration
echo -e "\n------ Repository setup complete ------"
echo "Current remotes:"
git remote -v
echo -e "\nGit configuration:"
git config --local --list | grep user
