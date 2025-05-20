#!/bin/bash

# Function to display usage
function show_usage {
    echo "Usage: $0 <repo-url> [branch]"
    echo ""
    echo "Example:"
    echo "  $0 https://github.com/tazomatalax/ai-project-template.git"
    echo ""
    echo "You will be prompted for the project name and location."
}

# Parse command line arguments
if [ $# -lt 1 ]; then
    show_usage
    exit 1
fi

REPO_URL=$1
BRANCH=${2:-main}

# Get project name from user
read -p "Enter project name: " PROJECT_NAME
if [ -z "$PROJECT_NAME" ]; then
    echo "Project name cannot be empty."
    exit 1
fi

# Get project location from user (default is current directory)
CURRENT_DIR=$(pwd)
read -p "Enter project location (press Enter for current directory: $CURRENT_DIR): " PROJECT_LOCATION
if [ -z "$PROJECT_LOCATION" ]; then
    PROJECT_LOCATION="$CURRENT_DIR"
fi

# Combine location and name to form full project path
PROJECT_FOLDER="$PROJECT_LOCATION/$PROJECT_NAME"

# Inform about pulling files from repo branch
echo "Creating a new project '$PROJECT_NAME' in '$PROJECT_FOLDER' by pulling template files from branch '$BRANCH' of repo: $REPO_URL"

# Clone the repository - quoting the path to handle spaces properly
git clone --single-branch --branch "$BRANCH" "$REPO_URL" "$PROJECT_FOLDER"

if [ $? -eq 0 ]; then
    # Unlink the project from the template repository
    rm -rf "$PROJECT_FOLDER/.git"
    echo "Project created successfully in '$PROJECT_FOLDER' and unlinked from template repo!"
    echo "Opening '$PROJECT_FOLDER' in a new VS Code window..."
    code "$PROJECT_FOLDER" -n
else
    echo "Failed to create the project."
    exit 1
fi
