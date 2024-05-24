#!/bin/bash

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Check if jq is installed using Homebrew
if ! brew list jq &> /dev/null; then
    echo "jq is not installed. Installing jq..."
    brew install jq
fi

# Your GitHub username
USERNAME=""

# Your GitHub personal access token with 'repo' scope
TOKEN=""

# Check if USERNAME variable is set, if not, prompt user for input
if [ -z "$USERNAME" ]; then
    read -p "Enter your GitHub username: " USERNAME
fi

# Check if TOKEN variable is set, if not, prompt user for input
if [ -z "$TOKEN" ]; then
    read -p "Enter your GitHub personal access token (with 'repo' scope): " TOKEN
fi

# Ask user for repository name
read -p "Enter repository name: " REPO_NAME

# Create a new repository using GitHub API
RESPONSE=$(curl -X POST \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token $TOKEN" \
  https://api.github.com/user/repos \
  -d "{\"name\":\"$REPO_NAME\"}")

# Extract the repository URL from the response
REPO_URL=$(echo $RESPONSE | jq -r .html_url)

echo "Repository created successfully at: $REPO_URL"

# Open the repository URL in a new terminal and print it in red
echo "Opening repository URL..."
echo -e "\033[0;31m$REPO_URL\033[0m" # Print URL in red

# Open the repository URL in the default web browser (for Linux)
if command -v xdg-open > /dev/null; then
  xdg-open $REPO_URL
# Open the repository URL in the default web browser (for macOS)
elif command -v open > /dev/null; then
  open $REPO_URL
else
  echo "Could not open URL. Please open $REPO_URL manually in your browser."
fi
