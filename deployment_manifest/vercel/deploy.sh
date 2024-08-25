#!/bin/bash

# Default values
DEFAULT_FOLDER="./apps/www"
VERCEL_API_KEY=""
PROJECT_FOLDER=""

# Parse arguments
while getopts f:k: flag
do
    case "${flag}" in
        f) PROJECT_FOLDER=${OPTARG};;
        k) VERCEL_API_KEY=${OPTARG};;
    esac
done

# Use default folder if not provided
if [ -z "$PROJECT_FOLDER" ]; then
    PROJECT_FOLDER=$DEFAULT_FOLDER
fi

# Change to the project directory
cd "$PROJECT_FOLDER" || { echo "Folder not found: $PROJECT_FOLDER"; exit 1; }

# Check if Vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "Vercel CLI not found. Installing it..."
    npm install -g vercel
fi

# Login to Vercel
echo "$VERCEL_API_KEY" | vercel login --token

# Extract the project name from package.json
PROJECT_NAME=$(jq -r '.name' < package.json)

# Check if the project exists on Vercel
PROJECT_EXISTS=$(vercel projects list --token $VERCEL_API_KEY | grep -w $PROJECT_NAME)

if [ -z "$PROJECT_EXISTS" ]; then
    # Project does not exist, create it
    vercel projects add $PROJECT_NAME --token $VERCEL_API_KEY
    vercel deploy --token $VERCEL_API_KEY -y --prod
else
    # Project exists, deploy the new version
    vercel deploy --prod --token $VERCEL_API_KEY
fi
