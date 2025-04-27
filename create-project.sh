#!/bin/bash

# Function to display usage
function show_usage {
    echo "Usage: $0 <new-project-folder> <repo-url> [branch]"
    echo ""
    echo "Example:"
    echo "  $0 ~/projects/ai-project https://github.com/tazomatalax/ai-project-template.git"
}

# Parse command line arguments
if [ $# -lt 2 ]; then
    show_usage
    exit 1
fi

PROJECT_FOLDER=$1
REPO_URL=$2
BRANCH=${3:-main}

# Inform about pulling files from repo branch
echo "Creating a new project in '$PROJECT_FOLDER' by pulling template files from branch '$BRANCH' of repo: $REPO_URL"

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